// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
var width = 480,
    height = 300
    radius = Math.min(width, height) /2 - 10;

var color = d3.scale.category20();

var data;

var reqData = {
    countries: ["US"],
    genders: ["M", "F", "O"],
    classes: [2015, 2016, 2017]
};
var getData = $.ajax({
    type: "GET",
    url: '/visualizations/student_demographic/data',
    data: reqData,
    dataType: 'json',
    success: function(json){
        alert('success');
        console.log(json);
        return json;
    },
    error: function(){
        alert('error');
        return;
    }
});
