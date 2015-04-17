// Require d3 for visualization
//= require d3

function reqToreqData(){
    var reqData = {
        "country": [],
        "gender": [],
        "class": []
    };
    $('.request').each(function(i, elem) {
        if (elem.checked) {
            reqData[$(elem).data("category")].push($(elem).data("query"));
        };
    })
    console.log(reqData);
    return reqData;
}

init();
function init(){
    var reqInitData = {
        countries: ["US"],
        genders: ["M", "F", "O"],
        classes: [2015, 2016, 2017]
    };
    // var reqInitData = {
    //     "country": [],
    //     "gender": [],
    //     "class": []
    // }

    $.ajax({
        type: "GET",
        url: '/visualizations/student_demographic/data',
        data: reqInitData,
        dataType: 'json',
        success: function(json){
            // alert('success');
            drawPie(json['countries'], "country");
            drawPie(json['genders'], "gender");
            drawPie(json['classes'], "class");
            drawPie(json['majors'], "major");
            return json;
        },
        error: function(){
            alert('error');
            return;
        }
    });

    var meow = d3.selectAll('.request')
        .on("click", function() {
            updateData(reqToreqData());
        });
}


function updateData(reqData){
    $.ajax({
        type: "GET",
        url: '/visualizations/student_demographic/data',
        data: reqData,
        dataType: 'json',
        success: function(json){
            // alert('success');
            console.log("json: ")
            console.log(json);
            updatePie(json['countries'], "country");
            updatePie(json['genders'], "gender");
            updatePie(json['classes'], "class");
            updatePie(json['majors'], "major");
            return json;
        },
        error: function(){
            alert('error');
            return;
        }
    });
}


function drawPie(data, section) {
    var width = 480,
        height = 300;

    var svg = d3.select("div#" + section).append("svg")
        .append("g")
        .attr("transform", "translate(" + width / 2 + ", " + height / 2 + ")");

    svg.append("g")
        .attr("class", "slices");
    svg.append("g")
        .attr("class", "labels");
    svg.append("g")
        .attr("class", "lines");

    updatePie(data, section);
}

function updatePie(data, section){
    var width = 480,
        height = 300
        radius = Math.min(width, height) /2 - 10;

    var arc = d3.svg.arc().outerRadius(radius * 0.9)
        .innerRadius(radius * 0.4);

    var outerArc = d3.svg.arc()
        .innerRadius(radius * 0.9)
        .outerRadius(radius * 0.9);

    var svg = d3.select("div#" + section + " svg");

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) {
            return d.count;   
        });

    var key = function(d) {
        return d.data.name; 
    };

    var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

    var slice = svg.select(".slices").selectAll("path.slice")
        .data(pie(data), key);

    slice.enter()
        .insert("path")
        .style("fill", function(d) { return color(d.data.count); })
        .attr("class", "slice");

    slice
        .transition().duration(1000)
        .attrTween("d", function(d) {
            this._current = this._current || d;
            var interpolate = d3.interpolate(this._current, d);
            this._current = interpolate(0);
            return function(t) {
                return arc(interpolate(t));
            };
        })

    slice.exit()
        .remove();

    //------text------
    var text = svg.select(".labels").selectAll("text")
        .data(pie(data), key);

    text.enter()
        .append("text")
        .attr("dy", ".25em")
        .text(function(d) {
            return d.data.name + "  " + d.data.percent + "%";
        });

    function midAngle(d){
        return d.startAngle + (d.endAngle - d.startAngle) / 2;
    }

    text.transition().duration(1000)
        .attrTween("transform", function(d) {
            this._current = this.current || d;
            var interpolate = d3.interpolate(this._current, d);
            this._current = interpolate(0);
            return function(t) {
                var d2 = interpolate(t);
                var pos = outerArc.centroid(d2);
                pos[0] = radius * (midAngle(d2) < Math.PI ? 1 : -1);
                return "translate(" + pos + ")";
            };
        })
        .styleTween("text-anchor", function(d) {
            this._current = this.current || d;
            var interpolate = d3.interpolate(this._current, d);
            this._current = interpolate(0);
            return function(t) {
                var d2 = interpolate(t);
                return midAngle(d2) < Math.PI ? "start" : "end";
            };
        });

    text.exit()
        .remove();

    //------Slice to Text Polylines------
    var polyline = svg.select(".lines").selectAll("polyline").data(pie(data), key);

    polyline.enter()
        .append("polyline")
        .style("fill", "none")
        .style("stroke-width", "2px")
        .style("stroke", "black")
        .style("opacity", "0.4");


    polyline.transition().duration(1000)
        .attrTween("points", function(d){
            this._current = this._current || d;
            var interpolate = d3.interpolate(this._current, d);
            this._current = interpolate(0);
            return function(t) {
                var d2 = interpolate(t);
                var pos = outerArc.centroid(d2);
                pos[0] = radius * 0.95 * (midAngle(d2) < Math.PI ? 1 : -1);
                return [arc.centroid(d2) + " " + outerArc.centroid(d2) + " " + pos];
            };
        });

    polyline.exit()
        .remove();

}
