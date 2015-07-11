<search>
  <div class="main">
    <div class="main-img">
      <h2>祭りを検索する</h2>
      <img src="images/home/main.jpg" alt="千葉市お祭りデータセンター">
    </div>
  </div>

  <article class="content">

    <form onsubmit={onSubmitSearch}>
      <h4>期間を選択してください。</h4>
      <div class="form-group row">
        <div class="col-xs-6">
          <input type="text" class="form-control" id="fromDate" >
        </div>
        <div class="col-xs-6">
          <input type="text" class="form-control" id="toDate" >
        </div>
      </div>

      <h4>地域を選択してください。</h4>
      <div class="form-group">
        <select class="form-control" aria-invalid="false">
          <option value="-">-</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
          <option value="千葉市緑区">千葉市緑区</option>
        </select>
      </div>

      <div class="form-group btn-area">
        <button type="submit" class="btn btn-search">検索する</button>
      </div>
    </form>

    <section class="result">
      <ul class="nav nav-tabs">
        <li role="presentation" class={active: path==='list'}><a href="#search/list?{queryString}">一覧表示</a></li>
        <li role="presentation" class={active: path==='map'}><a href="#search/map?{queryString}">地図</a></li>
        <li role="presentation" class={active: path==='cal'}><a href="#search/cal?{queryString}">カレンダー表示</a></li>
      </ul>
      <div>
        <search-list show={ path==='list' } request={request} ></search-list>
        <search-map show={ path==='map' } request={request} ></search-map>
        <search-calendar show={ path==='cal' } request={request} ></search-calendar>
      </div>
    </section>
  </article>

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
        fromDate: $(this.fromDate).val().replace(/\//g, "-"),
        toDate: $(this.toDate).val().replace(/\//g, "-")
      };
      fragment += "?" + $.param(param);
      riot.route(fragment);
    }

    /**
     * 検索結果表示画面切替時
     */
    riot.route.on('routeChange:search', function (path) {
      self.path = path;
      self.update();
    });

    /**
     * 検索画面表示時
     */
    riot.route.on('search', function (param) {
      self.queryString = $.param(param);
      if (param.fromDate) {
        $(self.fromDate).datepicker('update', new Date(param.fromDate))
      }
      if (param.toDate) {
        $(self.toDate).datepicker('update', new Date(param.toDate))
      }
      self.update();
    });
  </script>
  <style scoped>
    .main .main-img h2 {
      position: absolute;
      top: 80px;
      left: 0px;
      font-size: 36px;
      color: #fff;
      padding: 10px;
      padding-left: 20px;
      background-color: rgba(51, 51, 51, 0.6);
    }

    .content {
      position: relative;
    }

    form {
      padding: 20px 20px 0px 20px;
      background-color: rgba(255, 255, 255, 0.8);
      border: 2px solid #f5ac42;
    }

    form .btn-area {
      text-align: center;
    }

    form .btn-search {
      background-color: #3bb3e0;
      padding: 10px;
      position: relative;
      text-decoration: none;
      color: #fff;
      width: 100px;
      border: none;
      background-image: linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%);
      background-image: -webkit-linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%);
      background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, #2ca0ca), color-stop(1, #3eb8e5));
      -o-box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785;
      box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785;
      border-radius: 5px;
    }

    form .btn::before {
      background-color: #072239;
      content: "";
      display: block;
      position: absolute;
      width: 100%;
      height: 100%;
      padding-left: 2px;
      padding-right: 2px;
      padding-bottom: 4px;
      left: -2px;
      top: 5px;
      z-index: -1;
      border-radius: 6px;
      -o-box-shadow: 0px 1px 0px #fff;
      box-shadow: 0px 1px 0px #fff;
    }
    form .btn:active {
      color: #156785;
      text-shadow: 0px 1px 1px rgba(255, 255, 255, 0.3);
      background: #2ca0ca;
      -o-box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785;
      box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785;
      top: 7px;
    }
    form .btn:active::before {
      top: -2px;
    }

    @media all and (min-width: 641px) {
      form {
        box-shadow: 0px 0px 10px;
        position: absolute;
        top: -270px;
        right: 50px; }
    }

    @media only screen and (max-width: 640px) {
      form {
        padding: 20px 20px 0px 20px;
        margin-left: 10px;
        margin-right: 10px;
        background-color: rgba(255, 255, 255, 0.8);
        border: 2px solid #f5ac42; }
    }
  </style>
</search>
