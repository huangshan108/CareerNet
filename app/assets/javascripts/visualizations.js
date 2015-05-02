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
                // drawPie(preFormatData(json), "industry");
                var pie = new d3pie("pieChart", getD3PieOptions(json));
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
        });
}

/* This function takes an json data responsed from GeneralStats
 * and format it so that it can be passed into drawPie */
function preFormatData(data) {
    result = [];
    console.log(data);
    $.each(data, function(index, item) {
        temp = {};
        temp["count"] = item.stats.number;
        temp["name"] = item.class_name;
        temp["percent"] = item.student_percentage;
        result.push(temp);
    });
    // console.log(result);
    return result;
}

/* Get the default options for d3pie */
function getDefaultOptions() {
    return {
        "header": {
            "title": {
                "text": "",
                "fontSize": 24,
                "font": "Lato"
            },
            "subtitle": {
                "color": "#999999",
                "fontSize": 12,
                "font": "Lato"
            },
            "titleSubtitlePadding": 9
        },
        "footer": {
            "color": "#999999",
            "fontSize": 10,
            "font": "Lato",
            "location": "bottom-left"
        },
        "size": {
            "canvasWidth": 800,
            // "pieInnerRadius": "25%",
            "pieOuterRadius": "80%"
        },
        "data": {
            "smallSegmentGrouping": {
                "enabled": true,
                "value": 1
            },
            "sortOrder": "value-desc",
            "content": []
        },
        "labels": {
            "outer": {
                "format": "label-value1",
                "hideWhenLessThanPercentage": 1,
                "pieDistance": 32
            },
            "inner": {
                "hideWhenLessThanPercentage": 3
            },
            "mainLabel": {
                "fontSize": 13
            },
            "percentage": {
                "color": "#ffffff",
                "decimalPlaces": 0
            },
            "value": {
                "color": "#adadad",
                "fontSize": 13
            },
            "lines": {
                "enabled": true
            },
            "truncation": {
                "enabled": true
            }
        },
        "effects": {
            "pullOutSegmentOnClick": {
                "effect": "elastic",
                "speed": 400,
                "size": 8
            }
        },
        "misc": {
            "gradient": {
                "enabled": true,
                "percentage": 100
            },
            "colors": {
                "segments": all_colors_fewer
            }
        }   
    }
}

/* This function takes in json data responsed from GeneralStats
 * and return an json object that can be passed into d3pie constructor */
function getD3PieOptions(data) {
    var default_option = getDefaultOptions();
    var content_data = [];
    $.each(data, function(index, item) {
        temp = {};
        temp["label"] = item.class_name;
        temp["value"] = item.stats.number;
        // temp["color"] = pickOneColor();
        temp["average"] = item.stats.mean;
        content_data.push(temp);
    });
    default_option.data.content = content_data;

    default_option.header.title.text = "Student Destributions"
    console.log(default_option);
    return default_option;
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
                $("#pieChart").empty();
                var pie = new d3pie("pieChart", getD3PieOptions(json));
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
    console.log(data);
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
    .range(shuffle(all_colors));

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

/* 50 colors follow the gradient from red -> green -> red */
all_colors = ["#f02a60", "#e43953", "#e93e44", "#f33c29", "#eb6846", "#f06927", "#f77f1d", "#eea33f", "#d69f23", "#d7b41e", "#d8cb28", "#d7e030", "#b2cf25", "#a8dc29", "#8fcc38", "#82dc32", "#74f72d", "#5cd438", "#46f031", "#24f526", "#2ef048", "#21d14d", "#43e37f", "#29e183", "#44f1ae", "#26f4bc", "#38d2bb", "#42f0eb", "#33c6d5", "#2dccf7", "#19a1e4", "#42a7fa", "#2277e8", "#1d5ae0", "#3a56d0", "#1f2de9", "#4f46f6", "#502df9", "#511dd1", "#6f2ad2", "#8f1ef4", "#9937ce", "#d13bfe", "#c229d5", "#e73ee6", "#f230d9", "#fc2ec8", "#f722a8", "#f0439b", "#e72f76"];


/* 25 colors follow the gradient from blue -> yellow -> red */
all_colors_fewer = ['#4f46f6', '#2277e8', '#33c6d5', '#44f1ae', '#2ef048', '#74f72d', '#b2cf25', '#d69f23', '#eb6846', '#f02a60', '#f0439b', '#e73ee6', '#8f1ef4'];

/* Randomly pick a color from all_colors */
function pickOneColor() {
    return all_colors[Math.floor(Math.random() * 100 / 2)];
}

function shuffle(o){
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};
