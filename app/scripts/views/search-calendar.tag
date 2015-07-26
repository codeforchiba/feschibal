<search-calendar>
  <div id="calendar"></div>
  <script>

    var self = this;
    /** カレンダーエレメント */
    var $calendarEl = $(this.calendar);
    $calendarEl.fullCalendar({
      lang: 'ja',
      timezone: 'local',
      firstDay: 2,
      eventClick: function(calEvent, jsEvent, view) {
        riot.route("detail/" + calEvent.fes.id);
        return false;
      }
    });
    /**
     * カレンダー画面表示時
     */
    riot.route.on('search/cal', function(param){
      var searchParam = {
        fromDate: param.fromDate ? new Date(param.fromDate) : null,
        toDate: param.toDate ? new Date(param.toDate) : null
      };
      cfc.Event.find(searchParam).done(updateResult);
    });

    /**
     * 検索結果による画面更新
     *
     * @param res
     */
    var updateResult = function(res){
      // 祭りデータからイベントデータを生成します。
      var events = _.map(res.list, function(fes){
        return {
          title: fes.name,
          start: fes.getStartDate().getTime(),
          end: fes.getEndDate().getTime(),
          fes: fes
        };
      });
      $calendarEl.fullCalendar('render');
      $calendarEl.fullCalendar('removeEvents');
      $calendarEl.fullCalendar('addEventSource', events);
    };

  </script>
  <style scoped>
    .fc-event {
      margin-bottom: 5px;
      padding: 5px;
      cursor: pointer;
    }

    .fc-event:hover {
      opacity: 0.8;
    }

    .fc-event .fc-content {
      white-space: normal;
    }

    .fc-event .fc-content .fc-time {
      display: block;
    }

    .fc-sat {
      background-color:#FFF5F5;
    }

    .fc-sun {
      background-color:#FFF5F5;
    }
  </style>
</search-calendar>
