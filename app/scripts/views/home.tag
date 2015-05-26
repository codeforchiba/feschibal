<home>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">直近に開催される祭り</h3>
    </div>
    <div class="panel-body">
      工事中
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">祭りを検索する</h3>
    </div>
    <div class="panel-body row">
      <div class="col-lg-6">
        <h4>地域から探す</h4>
      </div>
      <div class="col-lg-6">
        <h4>日付から探す</h4>
        <table class="table">
          <tbody>
          <tr>
            <td><a href="javascript:void(0)" onclick={doSearchToday}>本日開催の祭り</a></td>
          </tr>
          <tr>
            <td><a href="javascript:void(0)" onclick={doSearchThisWeek}>今週開催の祭り</a></td>
          </tr>
          <tr>
            <td><a href="javascript:void(0)" onclick={doSearchThisWeekEnd}>今度の土日開催の祭り</a></td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <script>

    /**
     * 本日開催の祭り検索
     */
    doSearchToday(){
      var toDay = moment().format("YYYY-MM-DD");
      var param = {
        fromDate : toDay,
        toDate : toDay
      };
      riot.route("search/list?" + $.param(param));
    }

    /**
     * 今週開催の祭り検索
     */
    doSearchThisWeek(){
      var param = {
        fromDate :  moment().format("YYYY-MM-DD"),
        toDate : moment().weekday(7).format("YYYY-MM-DD")
      };
      riot.route("search/list?" + $.param(param));
    }

    /**
     * 今度の土日開催の祭り検索
     */
    doSearchThisWeekEnd(){
      var param = {
        fromDate :  moment().weekday(6).format("YYYY-MM-DD"),
        toDate : moment().weekday(7).format("YYYY-MM-DD")
      };
      riot.route("search/list?" + $.param(param));
    }
  </script>
</home>
