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
        <li role="presentation" class={active: path==='list'}><a href="#search/list?{queryString}">一覧表示</a></li>
        <li role="presentation" class={active: path==='cal'}><a href="#search/cal?{queryString}">カレンダー表示</a></li>
      </ul>
      <div>
        <fes-list if={ path === 'list' } request={request} ></fes-list>
        <fes-calendar if={ path === 'cal' } request={request} ></fes-calendar>
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

    /** 期間(from) */
    $(this.fromDate).datepicker(datepickerParam);
    /** 期間(to) */
    $(this.toDate).datepicker(datepickerParam);
    /** 検索リクエスト */
    this.request = riot.observable();
    /** 表示ページパス */
    this.path = null;
    /** 検索パラメータ */
    this.queryString = null;

    /**
     * 検索ボタン押下時
     */
    onSubmitSearch(e){
      var fragment = riot.route.currentPath();
      var param = {
        fromDate : $(this.fromDate).val().replace(/\//g, "-"),
        toDate : $(this.toDate).val().replace(/\//g, "-")
      };
      fragment += "?" + $.param(param);
      riot.route(fragment);
    }

    /**
     * 検索結果表示画面切替時
     */
    riot.route.on('routeChange:search', function(path){
      self.path = path;
      self.update();
    });

    /**
     * 検索画面表示時
     */
    riot.route.on('search', function(param){
      self.queryString = $.param(param);
      if(param.fromDate){
        $(self.fromDate).datepicker('update', new Date(param.fromDate))
      }
      if(param.toDate){
        $(self.toDate).datepicker('update', new Date(param.toDate))
      }
      self.update();
    });
  </script>
  <style>

  </style>
</search>
