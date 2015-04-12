// Require d3 for visualization
//= require d3


var data;

var reqInitData = {
    countries: ["US"],
    genders: ["M", "F", "O"],
    classes: [2015, 2016, 2017]
};
var getData = $.ajax({
    type: "GET",
    url: '/visualizations/student_demographic/data',
    data: reqInitData,
    dataType: 'json',
    success: function(json){
        alert('success');
        console.log(json);
        draw(json);
        return json;
    },
    error: function(){
        alert('error');
        return;
    }
});

function draw(json) {

    var width = 480,
        height = 300
        radius = Math.min(width, height) /2 - 10;

    var color = d3.scale.category20();

    var arc = d3.svg.arc().outerRadius(radius);

    var pie = d3.layout.pie();

    var svg = d3.select("div#country").append("svg")
        .datum([json['percent_us']])
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + ", " + height / 2 + ")");

    var arcs = svg.selectAll("g.arc")
        .data(pie)
      .enter().append("g")
        .attr("class", "arc");

    arcs.append("path")
        .attr("fill", function(d, i) { return color(i); })
      .transition()
        .ease("bounce")
        .duration(2000)
        .attrTween("d", tweenPie)
      .transition()
        .ease("elastic")
        .delay(function(d, i) { return 2000 + i * 50; })
        .duration(750)
        .attrTween("d", tweenDonut);

    function tweenPie(b) {
        b.innerRadius = 0;
        var i = d3.interpolate({ startAngle: 0, endAngle: 0}, b);
        return function(t) { return arc(i(t)); };
    }

    function tweenDonut(b) {
        b.innerRadius = radius * .6;
        var i = d3.interpolate({innerRadius: 0}, b);
        return function(t) { return arc(i(t)); };
    }
    console.log(svg);

}
