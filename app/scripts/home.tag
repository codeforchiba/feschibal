<home>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">直近に開催される祭り</h3>
    </div>
    <div class="panel-body">
      <fes-list listener={opts.listener} request={request}></fes-list>
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
            <td><a href="#list?param1=value1&param2=value2">本日開催の祭り</a></td>
          </tr>
          <tr>
            <td><a href="#list?param1=value3&param2=value4">今週開催の祭り</a></td>
          </tr>
          <tr>
            <td><a href="#list?param1=value5&param2=value6">今度の土日開催の祭り</a></td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <script>
    var self = this;

    // 検索リクエスト
    this.request = riot.observable();

    $.getJSON("data/home-test-data.json", function (data) {
      self.request.trigger('loaded', data);
      self.update();
    });
  </script>
</home>
