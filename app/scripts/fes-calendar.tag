<fes-calendar>
  <div id="calendar"></div>
  <script>

    var self = this;

    // データロード時
    opts.request.on('loaded', function(fesList){
      self.fesList = fesList;

      // 祭りデータからイベントデータを生成します。
      var events = _.map(fesList, function(fes){
        return {
          title: fes.name,
          start: fes.start,
          end: fes.end,
          fes: fes
        }
      });

      $calendarEl.fullCalendar('addEventSource', events);
    });

    var $calendarEl = $(this.calendar);
    var checkVisible = setInterval(function(){
      if(!$calendarEl.length || !$calendarEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      $calendarEl.fullCalendar({
        lang: 'ja',
        eventClick: function(calEvent, jsEvent, view) {
          opts.listener.onSelectFes(calEvent.fes);
          return false;
        },
        events: []
      });
    },50);
  </script>
  <style>
    fes-calendar .fc-event {
      margin-bottom: 5px;
      padding: 5px;
      cursor: pointer;
    }

    fes-calendar .fc-event:hover {
      opacity: 0.8;
    }

    fes-calendar .fc-event .fc-content {
      white-space: normal;
    }

    fes-calendar .fc-event .fc-content .fc-time {
      display: block;
    }
  </style>
</fes-calendar>
