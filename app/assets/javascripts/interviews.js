//= require fullcalendar

$(document).ready(function() {
    var todayDate = new Date();
    todayDate.setHours(0,0,0,0);

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here
        weekends: false,
        defaultView: 'agendaWeek',
        allDaySlot: false,
        slotDuration: '00:20:00',
        minTime: "10:00:00",
        maxTime: "16:00:00",
        editable: false,
        slotEventOverlap: false,
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'Click on interview slots to delete'
        },
        selectable: true,
        selectHelper: true,
        //this section is triggered when the event cell it's clicked
        select: function(start, end) {
          var eventData;
          //this validates that the user must insert a name in the input
          eventData = {
            start: start.format("YYYY-MM-DD HH:mm:ss"),
            end: end.format("YYYY-MM-DD HH:mm:ss")
            }
            //here i validate that the user can't create an event before today
            if (start < todayDate){
              alert('Please choose a time that is not already past.');
              $("#calendar").fullCalendar("unselect");
              return
            }
            //if everything it's ok, then the event is saved in database with ajax
            $.ajax({
              url: "/interviews/company/new",
              type: "POST",
              data: eventData,
              dataType: "json",
              success: function(json) {
                alert(json.msg);
                $("#calendar").fullCalendar("refetchEvents");
              },
             error: function(json) {
               alert('Failed to register interview slot');
             }
            });
          $("#calendar").fullCalendar("unselect");
        },
        eventClick: function (calEvent, jsEvent, view){
            if (calEvent.title == "Empty"){
              $.ajax({
                url: "/interviews/company/" + calEvent.id,
                type: "POST",
                //dataType: "json",
                data: { "_method": "delete" },
                success: function() {
                  $("#calendar").fullCalendar("removeEvents", calEvent.id);
                },
                error: function() {
                  alert("Error. Could not delete interview slot");
                }
              });
            }
            else{
              window.location = "/interviews/" + calEvent.id;
            }
        },
        slotMinutes: 20,
        events: '/interviews/company/',
        //events: function (start, end, timezone, callback){
        //  $.ajax({
        //    url: '/interviews/company',
        //    type: 'GET'
        //    dataType: 'json',
        //    data: {
        //      start: start.format("YYYY-MM-DD HH:mm:ss"),
        //      end: end.format("YYYY-MM-DD HH:mm:ss")
        //    },
        //    success: function(json){
        //      callback(json);
        //    },
        //    error: function(){
        //      alert('Failed to load appointments.');
        //    }
        //  });
        //},
        //timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5"
        })
});
