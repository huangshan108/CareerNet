//= require fullcalendar

$(document).ready(function() {
  var todayDate = new Date();
  todayDate.setHours(0,0,0,0);

  var currentLangCode = 'en';
  var currentView = 'agendaWeek';

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
      renderCalendar();
    }
  });

  // associate datepicker with fullCalendar
  $("#cal_jumpto").datepicker({
    onSelect: function(dateText, inst) {
        $('#myCalendar').fullCalendar('gotoDate', new Date(dateText));
        $('#myCalendar').fullCalendar('changeView', 'agendaDay');
    }
  });

  // make default selections and bind onchange function
  $('#cal_interviews').prop('checked', true);
  $('#cal_appointments').prop('checked', true);
  $('#cal_events').prop('checked', true);
  $('#cal_available').prop('checked', true);
  $("#cal_user_select").on('change', renderCalendar);

  // returns true if only fetch confirmed events, false for all available events
  function onlyMyEvents() {
    return !$('#cal_available').prop('checked');
  }

  // fetch events from server
  function fetchEvents(start, end, url, callback, confirmedOnly) {
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        data: {
            start: start.format("YYYY-MM-DD HH:mm:ss"),
            end: end.format("YYYY-MM-DD HH:mm:ss"),
            confirmed: confirmedOnly
        },
        success: function(json){
            callback(json);
        },
        error: function(){
            alert('Failed to load '+url);
        }
    });
  }

  function loadEvents(start, end, timezone, callback) {
    var confirmedOnly = onlyMyEvents();
    if ($('#cal_interviews').prop('checked')) {
        fetchEvents(start, end, '/calendar/interviews', callback, confirmedOnly);
    }
    if ($('#cal_events').prop('checked')) {
        fetchEvents(start, end, '/calendar/events', callback, confirmedOnly);
    }
    if ($('#cal_appointments').prop('checked')) {
        fetchEvents(start, end, '/calendar/appointments', callback, confirmedOnly);
    }
  }

  function renderCalendar() {
    $('#myCalendar').fullCalendar('destroy');
    $('#myCalendar').fullCalendar({
        // put your options and callbacks here
        allDaySlot: true,
        defaultDate: $("#cal_jumpto").datepicker("getDate"),
        slotDuration: '00:30:00',
        defaultView: currentView,
        editable: false,
        durationEditable: false,
        lang: currentLangCode,
        theme: true, // using JQuery UI
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month agendaWeek agendaDay'
        },
        viewRender: function(view, element) {
            currentView = view.name;
            $("#cal_jumpto").datepicker('setDate', $('#myCalendar').fullCalendar('getDate')._d);
        },
        selectable: true,
        selectHelper: true,
        events: loadEvents,
        //Manually direct user to appointment detail page rather than using 'url:' of Event obj
        //in fullcalendar
        //So that for staff, clicking on a slot will cancel the appointment if the slot is empty
        //and show details page for staff only if a student signed up for it
        eventClick: function(calEvent, jsEvent, view){
            window.location = calEvent.detailURL;
            return;
        },
        dragOpacity: "0.5"
    })      
  }

  renderCalendar();

});
