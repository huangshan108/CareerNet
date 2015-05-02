$(document).ready(function() {
    var usSalaryMap;

    // Dependencies needed for US Map viz
    var dependencies = {};
    dependencies.convertIdToStateName = d3.map();
    dependencies.convertStateNameToCode = d3.map();

    //Set all checkboxes to true initially
    $('.request').prop("checked", true);
    var reqInitData = reqToreqData();

    //Listen to onClick events on clickboxes
    //to updateData when clicked
    d3.selectAll('.request')
        .on("click", function() {
            updateData(usSalaryMap);
        });

    // Fetch data necessary for geo vizualization
    queue()
      .defer(d3.json, "../us.json")
      .defer(d3.tsv, "../us-state-names.tsv", function(d) {
        // On the fly creation of state name/id mappings
        dependencies.convertIdToStateName.set(d.id, d.name);
        dependencies.convertStateNameToCode.set(d.name, d.code);
      })
      .await(ready);

    // Initialize map
    function ready(error, response){
      usSalaryMap = new USsalaryMap(
          d3.select("div#usmap"),
          response,
          dependencies.convertIdToStateName,
          dependencies.convertStateNameToCode
      );
      updateData(usSalaryMap);
    }

});

//Grab selection from checkboxes and package into
//reqData
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


//Updates coloring of states when selection of checkboxes are altered
function updateData(usSalaryMap){
    var reqData = reqToreqData();
    $.ajax({
        type: "GET",
        url: '/smart-report/region-data',
        data: reqData,
        dataType: 'json',
        success: function(json){
            //update map
            usSalaryMap.render(json['usa_avg']);
            return json;
        },
        error: function(){
            alert('error');
            return;
        }
    });
}

/**
 * USsalaryMap
 *
 * Object encapsulating the U.S. state heatmap of monetary contributions. Each state's
 * color intensity maps to it's total contribution amount with respect to all other
 * states' contribution amounts.
 */
var USsalaryMap = function (selector, usTopoJSON, stateIdToStateNameMap, stateNameMap) {

    this.selector = selector;

    // Store height and width parameters
    this.width = 740;
    this.height = 500;

    // Parameters for rendering U.S. map from TopoJSON
    this.projection = d3.geo.albersUsa()
        .scale(1000)
        .translate([this.width / 2, this.height / 2]);

    this.geopath = d3.geo.path()
        .projection(this.projection);

    this.stateNameMap = stateNameMap;

    // Store geography features
    this.us = usTopoJSON;
    this.landSubunit = topojson.feature(usTopoJSON, usTopoJSON.objects.land);
    console.log("statePaths");
    this.statePaths = topojson.feature(usTopoJSON, usTopoJSON.objects.states).features.map(function(d) {
        d['label'] = stateIdToStateNameMap.get(d['id']);
        d['average'] = 0;
        console.log(d);
        return d;
    });

    this.setupMap();

    // Initialize selected states
    this._selectedStates = d3.set();
};

/*
 * setupMap()
 *
 * Sets up the SVG container and inspection text.
 */
USsalaryMap.prototype.setupMap = function () {
    // Create the map's svg container
    this.svg = this.selector.append("svg")
        .attr("width", this.width)
        .attr("height", this.height);

    // Render the bounding land region first
    this.svg.insert("path", ".graticule")
        .datum(this.landSubunit)
        .attr("class", "land")
        .attr("d", this.geopath);

    // Container for holding the states
    this.stateGroup = this.svg.append("g")
        .attr("class", "state-group");

    //Select objects to displace text
    this.stateText = d3.select("b#state");
    this.avgText = d3.select("p#average");
    this.countText = d3.select("p#count");

    // Add state paths
    this._states = this.stateGroup.selectAll('path')
        .data(this.statePaths, function(d) { 
            return d.label;
        });

    this._states.enter().append('path')
        .attr('class', 'states')
        .attr('d', this.geopath)
        .attr('fill', '#E8F5E9');
};

//Renders the map with each state path colored based on a color mapping determined
//by the average salary of each state.
USsalaryMap.prototype.render = function (data) {
    // Hack needed to access class object in functions defined in this scope
    var that = this;
    var count = 0;

    var moneyColorScale = d3.scale.sqrt()
        .domain([
            d3.min(data, function (d) { return d['average']; }),
            d3.max(data, function (d) { return d['average']; })
        ])
        .range(['#E8F5E9', '#4CAF50']).nice();

    this.states = this.stateGroup.selectAll('path')
        .data(data, function(d) {
            return d['label'];
        });

    /** Enter phase **/
    // No enter phase. We'll be binding to the state SVG paths that have already 
    // been rendered. (see assignment of this._states)

    /** Update phase **/
    console.log("Update");
    console.log(this.states);
    this.states.transition().duration(500)
        .attr("fill", function(d) {
            return moneyColorScale(d['average']);
        });

    /** Exit phase **/
    this.states.exit().transition().duration(500)
        .attr("fill", function(d) {
            return moneyColorScale(d['average']);
        });

    /** Setup/Rebind event handlers **/
    
    //For states that does have enough data,
    //set inspection info
    this.states.on('mouseover', function(d, e, p){
        d3.select(this).attr("fill", '#FF8300'); 
        var fullState = d['label'];
        that.setInspectionInfo(fullState, d['average'], d['count']);
    });

    //For states that does not have enough data,
    //set inspection info
    this.states.exit().on('mouseover', function(d, e, p){
        d3.select(this).attr("fill", '#FF8300'); 
        var fullState = d['label'];
        that.setNoDataInfo(fullState);
    });

    //For states that does have enough data,
    //clear inspection info
    this.states.on('mouseout', function(d, e, p){
        that.clearInspectionInfo();
        d3.select(this).attr("fill", function(d){
            return moneyColorScale(d['average']);
        });
    });

    //For states that does not have enough data,
    //clear inspection info
    this.states.exit().on('mouseout', function(d, e, p){
        that.clearInspectionInfo();
        d3.select(this).attr("fill", function(d){
            return moneyColorScale(d['average']);
        });
    });

};


//Formats integer into currency (without decimal places)
USsalaryMap.prototype.currencyFormatter = d3.format('$,');


//Set inspection Info for states with enough info on the side of the map
USsalaryMap.prototype.setInspectionInfo = function(stateName, amount, count) {
    this.stateText.text(stateName);
    this.avgText.text("Avg. Salary:  " + this.currencyFormatter(amount));
    this.countText.text("#Offers: " + count);
};

//Set Info on states that does not have enough data
USsalaryMap.prototype.setNoDataInfo = function(stateName){
    this.stateText.text(stateName);
    this.avgText.text('No data');
};


//Clears the inspection Info on the side of the map
USsalaryMap.prototype.clearInspectionInfo = function() {
    this.stateText.text('');
    this.avgText.text('');
    this.countText.text('');
};
