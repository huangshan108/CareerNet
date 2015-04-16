$(document).ready(function() {
  var todayDate = new Date();
  todayDate.setHours(0,0,0,0);


  var currentLangCode = 'en';
  // build the language selector's options
  $.each($.fullCalendar.langs, function(langCode) {
    $('#lang-selector').append(
      $('<option/>')
        .attr('value', langCode)
        .prop('selected', langCode == currentLangCode)
        .text(langCode)
    );
  });
  // rerender the calendar when the selected option changes
  $('#lang-selector').on('change', function() {
    if (this.value) {
      currentLangCode = this.value;
      $('#myCalendar').fullCalendar('destroy');
      renderCalendar();
    }
  });



  function renderCalendar() {
    $('#myCalendar').fullCalendar({
        // put your options and callbacks here
        allDaySlot: true,
        slotDuration: '00:30:00',
        editable: false,
        durationEditable: false,
        lang: currentLangCode,
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month agendaWeek agendaDay'
        },
        selectable: true,
        // selectHelper: true,
        // //this section is triggered when the event cell it's clicked
        // select: function(start, end) {
        //   var eventData;
        //   //this validates that the user must insert a name in the input
        //   eventData = {
        //     start: start.format("YYYY-MM-DD HH:mm:ss"),
        //     end: end.format("YYYY-MM-DD HH:mm:ss")
        //     }
        //     //here i validate that the user can't create an event before today
        //     if (start < todayDate){
        //       alert('Please choose a time that is not already past.');
        //       $("#calendar").fullCalendar("unselect");
        //       return
        //     }
        //     //if everything it's ok, then the event is saved in database with ajax
        //     $.ajax({
        //       url: "/appointments/staff/new",
        //       type: "POST",
        //       data: eventData,
        //       dataType: "json",
        //       success: function(json) {
        //         // alert(json.msg);
        //         $("#calendar").fullCalendar("refetchEvents");
        //       },
        //      error: function(json) {
        //        alert('Failed to register appointments');
        //      }
        //     });
        //   $("#calendar").fullCalendar("unselect");
        // },
        // eventClick: function (calEvent, jsEvent, view){
        //   // var result = confirm("Are you sure you want to delete this appointment?");
        //     // if (result){
        //       $.ajax({
        //         url: "/appointments/staff/" + calEvent.id,
        //         type: "POST",
        //         dataType: "json",
        //         data: { "_method": "delete" },
        //         success: function() {
        //           // alert("Successfully deleted appointment");
        //         },
        //         error: function() {
        //           alert("Error. Could not delete appointment");
        //         }
        //       });
        //       $("#calendar").fullCalendar("refetchEvents");
        //     // }
        // },
        // slotMinutes: 20,
        // events: '/appointments/staff/',
        // //events: function (start, end, timezone, callback){
        // //  $.ajax({
        // //    url: '/appointments/staff',
        // //    type: 'GET'
        // //    dataType: 'json',
        // //    data: {
        // //      start: start.format("YYYY-MM-DD HH:mm:ss"),
        // //      end: end.format("YYYY-MM-DD HH:mm:ss")
        // //    },
        // //    success: function(json){
        // //      callback(json);
        // //    },
        // //    error: function(){
        // //      alert('Failed to load appointments.');
        // //    }
        // //  });
        // //},
        // //timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5"
        })      
  }

  renderCalendar();


});
