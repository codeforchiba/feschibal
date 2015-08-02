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
        <select class="form-control" id="cities"></select>
      </div>

      <div class="form-group btn-area">
        <button type="submit" class="btn btn-search">検索する</button>
      </div>
    </form>

    <section class="result">
      <ul class="tab">
        <li class={'tab-item': true, active: path==='list'}>
          <a href="#search/list?{queryString}">
            <img src="images/search/icon01.svg">
            <p>一覧</p>
          </a>
        </li>
        <li class={'tab-item': true, active: path==='map'}>
          <a href="#search/map?{queryString}">
            <img src="images/search/icon02.svg">
            <p>地図</p>
          </a>
        </li>
        <li class={'tab-item': true, active: path==='cal'}>
          <a href="#search/cal?{queryString}">
            <img src="images/search/icon03.svg">
            <p>カレンダー</p>
          </a>
        </li>
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
      clearBtn: true,
      weekStart: 2
    };

    /** 期間(from) */
    this.$fromDate = $(this.fromDate).datepicker(datepickerParam);
    /** 期間(to) */
    this.$toDate = $(this.toDate).datepicker(datepickerParam);
    /**  */
    this.$cities = $(this.cities);
    /** 検索リクエスト */
    this.request = riot.observable();
    /** 表示ページパス */
    this.path = null;
    /** 検索パラメータ */
    this.queryString = null;

    // 地域一覧の取得
    cfc.City.findAllWards().then(function(cities){
      var options = [];
      options.push($("<option value=''>-</option>"));
      _.each(cities, function(city){
        options.push($("<option value='"+city.cityCode+"'>"+city.city+"</option>"));
      });
      self.$cities.append(options);
    });

    /**
     * 検索ボタン押下時
     */
    onSubmitSearch(e){
      var fragment = riot.route.currentPath();
      var param = {
        fromDate: this.$fromDate.val().replace(/\//g, "-"),
        toDate: this.$toDate.val().replace(/\//g, "-"),
        cities: [this.$cities.val()]
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
        self.$fromDate.datepicker('update', new Date(param.fromDate));
      } else {
        self.$fromDate.datepicker('clearDates');
      }
      if (param.toDate) {
        self.$toDate.datepicker('update', new Date(param.toDate))
      } else {
        self.$toDate.datepicker('clearDates');
      }
      if (param.cities && param.cities.length > 0) {
        self.$cities.val(param.cities[0]);
      } else {
        self.$cities.val("");
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

    /** 検索フォーム */
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
      margin-bottom: 30px;
      background-image: linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%);
      background-image: -webkit-linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%);
      background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, #2ca0ca), color-stop(1, #3eb8e5));
      -o-box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785;
      box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785;
      border-radius: 5px;
    }

    form .btn-search:active {
      color: #156785;
      text-shadow: 0px 1px 1px rgba(255, 255, 255, 0.3);
      background: #2ca0ca;
      -o-box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785;
      box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785;
      top: 7px;
    }
    form .btn:active:before {
      top: -2px;
    }
    form .btn:hover {
      color: #fff;
    }

    /** 検索タブ */
    .tab {
      background: #D75247;
      margin-bottom: 30px;
    }

    .tab .tab-item {
      float: left;
      width: 33.1%;
      border-right: #8B332C solid 1px;
      font-size: 20px;
      font-weight: 700;
      text-align: center;
    }

    .tab .tab-item a {
      display: block;
      color: #fff;
      padding: 20px 0;
      text-decoration: none;
    }

    .tab .tab-item a img {
      width: 100px;
    }

    .tab .tab-item a p {
      margin-bottom: 0;
    }

    .tab .tab-item a:hover, .tab .tab-item.active a {
      background: #BB463C;
    }

    .tab .tab-item:last-child, .tab .tab-item:nth-of-type(3n) {
      border-right: none;
    }

    .tab:after {
      content: ".";
      display: block;
      height: 0;
      font-size: 0;
      clear: both;
      visibility: hidden;
    }

    @media all and (min-width: 641px) {
      form {
        box-shadow: 0px 0px 10px;
        position: absolute;
        top: -270px;
        right: 50px; }
    }

    @media only screen and (max-width: 640px) {
      .main .main-img h2 {
        top: 40px;
        font-size: 26px;
        padding-left: 10px;
      }

      form {
        padding: 10px 10px 0px 10px;
        margin-left: 0px;
        margin-right: 0px;
        background-color: #f5ac42;
        border: none;
      }

      form h4{
        font-size: 13px;
        color: #fff;
      }

      form .btn-search{
        padding: 10px;
        position: relative;
        text-decoration: none;
        color: #fff;
        width: 100%;
        border: none;
        background-image: linear-gradient(bottom, #C53333 0%, #ED6060 100%);
        background-image: -webkit-linear-gradient(bottom, #C53333 0%, #ED6060 100%);
        background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, #C53333), color-stop(1, #ED6060));
        -o-box-shadow: inset 0px 1px 0px #BB3535, 0px 6px 0px #901818;
        box-shadow: inset 0px 1px 0px #BB3535, 0px 6px 0px #901818;
        border-radius: 5px;
      }

      form .btn-search:active {
        background: #C53333;
        color: #999;
        -o-box-shadow: inset 0px 1px 0px #BB3535, 0px -1px 0px #901818;
        box-shadow: inset 0px 1px 0px #BB3535, 0px -1px 0px #901818;
        top: 7px;
      }

      form .btn-area {
        margin-bottom: 0;
      }

      .tab{
        margin-bottom:0px;
      }

      .tab .tab-item{
        font-size: 16px;
      }
    }
  </style>
</search>
