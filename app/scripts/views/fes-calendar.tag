<fes-calendar>
  <div id="calendar"></div>
  <script>

    var self = this;

    /** カレンダーエレメント */
    var $calendarEl = $(this.calendar);
    /** カレンダーイベントデータ */
    var events = [];

    /**
     * カレンダー画面表示時
     */
    riot.route.on('search/cal', function(param){
      $calendarEl.fullCalendar({
        lang: 'ja',
        eventClick: function(calEvent, jsEvent, view) {
          opts.listener.onSelectFes(calEvent.fes);
          return false;
        },
        events: events
      });
    });

    /**
     * 祭りデータロード時
     */
    opts.request.on('loaded', function(fesList){
      self.fesList = fesList;

      // 祭りデータからイベントデータを生成します。
      events = _.map(fesList, function(fes){
        return {
          title: fes.name,
          start: fes.start,
          end: fes.end,
          fes: fes
        }
      });
      $calendarEl.fullCalendar('removeEvents');
      $calendarEl.fullCalendar('addEventSource', events);
    });

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
