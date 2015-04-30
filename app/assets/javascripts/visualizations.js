// Require d3 for visualization
//= require d3


var WIDTH = 500;
var HEIGHT = 200;

var general_stats_template = ['industry', 'organization'];
var stats_table;

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
    return reqData;
}


//       <tbody>

//       </tbody>
//     </table>
// </div>';

// $(function() {
    console.log("here");
    var template = $('h1').data("template");
    init(template);
// });

function init(template){
    var reqInitData = reqToreqData();

    $.ajax({
        type: "GET",
        url: '/smart-report/' + template + '-data',
        data: reqInitData,
        dataType: 'json',
        success: function(json){
            // alert('success');
            // if (json['too_few']){
            //     alert("There are too few data that fit the category for meaningful visualization.");
            //     return;
            // }
            // need to render table
            if (general_stats_template.indexOf(template) != -1 ) {
                renderTable(json, template);
            } else if (template == "overview") {
                drawPie(json['countries'], "country");
                drawPie(json['genders'], "gender");
                drawPie(json['classes'], "class");
                drawPie(json['majors'], "major");
            };
            return json;
        },
        error: function(){
            alert('error');
            return;
        }
    });

    var meow = d3.selectAll('.request')
        .on("click", function() {
            updateData(template, reqToreqData());
            // renderTable(json, template);
        });

   

}

function renderTable(data, template) {
    // console.log(data);
    $('.dataTables_wrapper').remove();
    stats_table_header = '<table class="general-stats-table data-table table table-striped"><thead><tr><th style="text-transform: capitalize;">'+template+'</th><th> Student Percentage </th><th> Student Count </th><th> Highest Paid </th><th> Lowest Paid </th><th>Average Paid</th><th>Mode Paid</th><th>Median Paid</th><th>Standard Deviation</th><th>1st Quartile</th><th>2nd Quartile</th><th>3rd Quartile</th></tr></thead>';
    stats_table_body = "<tbody>";
    $.each(data, function(i, elem) {
        stats_table_body += "<tr><th>"+ elem.class_name+"</th>"
                         + "<th>"+ (elem.student_percentage*100).toFixed(2)+" %</th>"
                         + "<th>"+ elem.stats.number+"</th>"
                         + "<th>$"+ formatNum(elem.stats.max, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.min, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.mean, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.mode, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.median, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.standard_deviation, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.q1, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.q2, 0)+"</th>"
                         + "<th>$"+ formatNum(elem.stats.q3, 0)+"</th></tr>";
    })
    $('.general-stats-table-container').html(stats_table_header+stats_table_body+ "</tbody></table>");
    $('.general-stats-table').dataTable({
      "pageLength": 25,
      "lengthMenu": [ 25, 50, 100 ],
      "scrollX": true
    });
}

// this function takes in a number and decimal place we want to leave after formatting
function formatNum(num, decimal) {
    if (num != null) {
        return num.toFixed(decimal);
    } else {
        return "N/A";
    }
}

function updateData(template, reqData){
    $.ajax({
        type: "GET",
        url: '/smart-report/' + template + '-data',
        data: reqData,
        dataType: 'json',
        success: function(json){
            // alert('success');
            // if (json['too_few']){
            //     alert("There are too few data that fit the category for meaningful visualization.");
            //     return;
            // }
            if (general_stats_template.indexOf(template) != -1 ) {
                renderTable(json, template);
            } else if (template == "overview") {
                updatePie(json['countries'], "country");
                updatePie(json['genders'], "gender");
                updatePie(json['classes'], "class");
                updatePie(json['majors'], "major");
            };
            return json;
        },
        error: function(){
            alert('error');
            return;
        }
    });
}


function drawPie(data, section) {
    var width = WIDTH,
        height = HEIGHT;

    var svg = d3.select("div#" + section).append("svg")
        .append("g");
    
    svg.attr("transform", "translate(" + width / 2 + ", " + height / 2 + ")");

    svg.append("g")
        .attr("class", "slices");
    svg.append("g")
        .attr("class", "labels");
    svg.append("g")
        .attr("class", "lines");
    svg.append("text")
        .attr("class", "percent")
        .attr("transform", "translate(0,0)")
        .attr("dy", ".45em")
        .style("text-anchor", "middle");

    updatePie(data, section);
}

function mergeWithFirstEqualZero(first, second){
    var secondSet = d3.set(); second.forEach(function(d) { secondSet.add(d.name); });
    var onlyFirst = first
        .filter(function(d){ return !secondSet.has(d.name) })
        .map(function(d) { return {name: d.name, count: 0, percent: d.percent}; });
    return d3.merge([second, onlyFirst])
        .sort(function(a,b) {
            return d3.ascending(a.name, b.name);
        });
}

function updatePie(data, section){
    var width = WIDTH,
        height = HEIGHT,
        radius = 100;

    var arc = d3.svg.arc().outerRadius(radius * 0.8)
        .innerRadius(radius * 0.35);

    var outerArc = d3.svg.arc()
        .innerRadius(radius * 0.9)
        .outerRadius(radius * 0.9);

    var svg = d3.select("div#" + section + " svg");

    var data0 = svg.select(".slices").selectAll("path.slice")
        .data().map(function(d) { return d.data; });
    if (data0.length == 0) data0 = data;
    var was = mergeWithFirstEqualZero(data, data0);
    var is = mergeWithFirstEqualZero(data0, data);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) {
            return d.count;   
        });

    var key = function(d) {
        return d.data.name; 
    };

    var color = d3.scale.ordinal()
    .range(shuffle(["#4D4D4D", "#5DA5DA", "#FAA43A", "#60BD68", "#F17CB0", "#B276B2", "#DECF3F", "#F15854"]));

    var slice = svg.select(".slices").selectAll("path.slice")
        .data(pie(was), key);

    slice.enter()
        .insert("path")
        .attr("class", "slice")
        .style("fill", function(d) { return color(d.data.name); })
        .each(function(d) {
            this._current = d;
        });


    slice = svg.select(".slices").selectAll("path.slice")
        .data(pie(is), key);

    slice.on("mouseover", function(d){
        var perc = svg.select(".percent");
        perc.text(d.data.percent + "%")
    })
        .on("mouseout", function(d){
            var perc = svg.select(".percent");
            perc.text("")
        });
    slice.transition().duration(1000)
        .attrTween("d", function(d) {
            var interpolate = d3.interpolate(this._current, d);
            var _this = this;
            return function(t) {
                _this._current = interpolate(t);
                return arc(_this._current);
            };
        });

    slice = svg.select(".slices").selectAll("path.slice")
        .data(pie(data), key);

    slice.exit().transition().delay(1000).duration(0)
        .remove();

    //------text------
    var text = svg.select(".labels").selectAll("text")
        .data(pie(was), key);

    text.enter()
        .append("text")
        .attr("dy", ".25em")
        .style("opacity", 0)
        .text(function(d) {
            var name = d.data.name;
            var nameHash = {
                "male": "Male",
                "female": "Female",
                "other": "Others"
            }
            if (d.data.name in nameHash){
                name = nameHash[name]
            }
            return name;
        })
        .each(function(d) {
            this._current = d;
        });

    function midAngle(d){
        return d.startAngle + (d.endAngle - d.startAngle) / 2;
    }

    text = svg.select(".labels").selectAll("text")
        .data(pie(is), key);

    text.transition().duration(1000)
        .style("opacity", function(d){
            return d.data.count == 0 ? 0 : 1;
        })
        .attrTween("transform", function(d) {
            var interpolate = d3.interpolate(this._current, d);
            var _this = this;
            return function(t) {
                var d2 = interpolate(t);
                _this._current = d2;
                var pos = outerArc.centroid(d2);
                pos[0] = radius * (midAngle(d2) < Math.PI ? 1 : -1);
                return "translate(" + pos + ")";
            };
        })
        .styleTween("text-anchor", function(d) {
            var interpolate = d3.interpolate(this._current, d);
            var _this = this;
            return function(t) {
                var d2 = interpolate(t);
                var anchor = midAngle(d2) < Math.PI ? "start" : "end";
                return anchor;
            };
        });

    text = svg.select(".labels").selectAll("text")
        .data(pie(data), key);

    text.exit().transition().delay(1000)
        .remove();

    //------Slice to Text Polylines------
    var polyline = svg.select(".lines").selectAll("polyline")
        .data(pie(was), key);

    polyline.enter()
        .append("polyline")
        .style("fill", "none")
        .style("stroke-width", "2px")
        .style("stroke", "black")
        .style("opacity", 0)
        .each(function(d) {
            this._current = d;
        });

    polyline = svg.select(".lines").selectAll("polyline")
        .data(pie(is), key);

    polyline.transition().duration(1000)
        .style("opacity", function(d) {
            return d.data.count == 0? 0 : .5;
        })
        .attrTween("points", function(d){
            this._current = this._current;
            var interpolate = d3.interpolate(this._current, d);
            var _this = this;
            return function(t) {
                var d2 = interpolate(t);
                _this._current = d2;
                var pos = outerArc.centroid(d2);
                pos[0] = radius * 0.95 * (midAngle(d2) < Math.PI ? 1 : -1);
                return [arc.centroid(d2), outerArc.centroid(d2), pos];
            };
        });

    polyline = svg.select(".lines").selectAll("polyline")
        .data(pie(data), key);

    polyline.exit().transition().delay(1000)
        .remove();
}

function shuffle(o){
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
