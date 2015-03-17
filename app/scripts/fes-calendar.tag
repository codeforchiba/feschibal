<fes-calendar>
  <div id="calendar"></div>

  <script>

    var $calendarEl = $(this.calendar);
    var checkVisible = setInterval(function(){
      if(!$calendarEl.length || !$calendarEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      $calendarEl.fullCalendar();
    },50);
  </script>
</fes-calendar>
