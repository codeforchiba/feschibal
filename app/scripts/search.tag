<search>
  <div class="row">
    <div class="col-lg-3">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title">祭りを検索する</h3>
        </div>
        <div class="panel-body">
          <form class="form-horizontal" onsubmit={onSubmitSearch}>
            <h4>期間を指定する</h4>
            <div class="form-group">
              <label for="fromDate" class="col-sm-2 control-label">From:</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="fromDate" >
              </div>
            </div>
            <div class="form-group">
              <label for="toDate" class="col-sm-2 control-label">To:</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="toDate" >
              </div>
            </div>
            <h4>地域を指定する</h4>
            <div class="form-group">
              <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">検索する</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="col-lg-9">
      <ul class="nav nav-tabs">
        <li role="presentation" class={active: opts.restype==='list'}><a href="#list?{$.param(opts.searchparam)}">一覧表示</a></li>
        <li role="presentation" class={active: opts.restype==='cal'}><a href="#cal?{$.param(opts.searchparam)}">カレンダー表示</a></li>
      </ul>
      <div>
        <fes-list if={ opts.restype === 'list' } request={request} listener={opts.listener}></fes-list>
        <fes-calendar if={ opts.restype === 'cal' } request={request} listener={opts.listener}></fes-calendar>
      </div>

    </div>
  </div>

  <script>
    var self = this;

    var datepickerParam = {
      format: 'yyyy/mm/dd',
      language: 'ja',
      orientation: 'top',
      todayHighlight: true,
      autoclose: true,
      clearBtn: true
    };

    // 期間(from)
    $(this.fromDate).datepicker(datepickerParam);

    // 期間(to)
    $(this.toDate).datepicker(datepickerParam);

    // 検索リクエスト
    this.request = riot.observable();

    // 検索ボタン押下時
    onSubmitSearch(e){
      $.getJSON("data/test-data.json", function (data) {
        self.request.trigger('loaded', data);
        self.update();
        return false;
      });
    }
  </script>
  <style>

  </style>
</search>
