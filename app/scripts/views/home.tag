<home>
  <div class="main">
    <div class="main-img">
      <img src="images/home/main.jpg" alt="千葉市お祭りデータセンター">
    </div>
  </div>

  <article class="content">
    <section class="homesearch">
      <div class="homesearch-list">
        <a href="javascript:void(0)" onclick={doClickCitySearchPanel}>
          <img src="images/home/icon01.svg">
          <p>地域から探す</p>
        </a>
      </div>

      <div class="homesearch-list">
        <a href="javascript:void(0)" onclick={doSearchToday}>
          <img src="images/home/icon02.svg">

          <p>本日開催の祭り</p>
        </a>
      </div>

      <div class="homesearch-list">
        <a href="javascript:void(0)" onclick={doSearchThisWeekEnd}>
          <img src="images/home/icon03.svg">

          <p>土日開催の祭り</p>
        </a>
      </div>
    </section>
    <section id="city-search" style="display:none">
      <ul class="homesearch">
        <li class="homesearch-list" each={ city in cities }>
          <a href="javascript:void(0)" onclick={parent.doSearchCity}>
            <p>{city.city}</p>
            <p>{parent.fesCount[city.cityCode]}件</p>
          </a>
        </li>
      </ul>
    </section>
    <section class="week">
      <dl class="week-day">
        <dt>今週開催の祭り</dt>
        <dd>{moment(startDateOfWeek).format('M/D')} - {moment(endDateOfWeek).format('M/D')}</dd>
      </dl>

      <div class="week-map">
        <fes-map feslist={fesList}></fes-map>
      </div>

      <fes-list feslist={fesList}></fes-list>
    </section>
  </article>

  <script>
    var self  = this;

    // 今週開催の祭り一覧
    this.fesList = [];

    // 区一覧
    this.cities = [];

    // 区毎の祭りの件数
    this.fesCount = {"a":"b"};

    // 今週の開始日付と終了日付
    this.startDateOfWeek = moment().weekday(1).toDate();
    this.endDateOfWeek = moment().weekday(7).toDate();

    /**
     * 地域から探すボタン押下時
     */
    doClickCitySearchPanel(e){
      $(self["city-search"]).slideToggle();
    }

    /**
     * 本日開催の祭り検索
     */
    doSearchToday(e){
      var toDay = moment().format("YYYY-MM-DD");
      var param = {
        fromDate: toDay,
        toDate: toDay
      };
      riot.route("search/list?" + $.param(param));
    }

    /**
     * 今度の土日開催の祭り検索
     */
    doSearchThisWeekEnd(e){
      var param = {
        fromDate: moment().weekday(6).format("YYYY-MM-DD"),
        toDate: moment().weekday(7).format("YYYY-MM-DD")
      };
      riot.route("search/list?" + $.param(param));
    }

    /**
     * 指定地域検索
     */
    doSearchCity(e){
      var toDay = moment().format("YYYY-MM-DD");
      var param = {
        fromDate: toDay,
        cities: [e.item.city.cityCode]
      };
      riot.route("search/list?" + $.param(param));
    }

    /**
     * Home画面表示時
     */
    riot.route.on('home', function(param){
      self.tags["fes-map"].trigger("show");
      // 今週開催の祭り取得
      var searchParam = {
        fromDate: self.startDateOfWeek,
        toDate: self.endDateOfWeek,
        order: "periods"
      };
      cfc.Event.find(searchParam).done(function(res){
        self.fesList = res.list;
        self.update();
      });
      // 区一覧の取得
      cfc.City.findAllWards().then(function(cities){
        self.cities = cities;
        var requests = _.map(cities, function(city){
          var citySearchParam = {
            fromDate: new Date(),
            cities: [city.cityCode]
          };
          return cfc.Event.find(citySearchParam).done(function(res){
            self.fesCount[city.cityCode] = res.total;
          });
        });
        $.when.apply($, requests).done(function(){
          self.update();
        });
      });
    });
  </script>

  <style scoped>
    .homesearch {
      background: #f5ac42;
      margin-bottom: 30px;
    }

    .homesearch .homesearch-list {
      float: left;
      width: 33.2%;
      border-right: #cb7e01 solid 1px;
      font-size: 20px;
      font-weight: bold;
      text-align: center;
    }

    .homesearch .homesearch-list:nth-child(3n) {
      border-right: 0px;
    }

    .homesearch .homesearch-list a {
      display: block;
      color: #fff;
      padding: 20px 0px;
      text-decoration: none;
    }

    .homesearch .homesearch-list a img{
      width: 100px;
    }

    .homesearch .homesearch-list a p {
      margin-bottom: 0px;
    }

    .homesearch .homesearch-list a:hover {
      background: #ff9700;
    }

    .homesearch .homesearch-list:last-child {
      border-right: none;
    }

    .homesearch #city-search .homesearch-list {
      display: inline-block;
      float: none;
      border-top: #cb7e01 solid 1px;
    }

    .homesearch:after {
      content: ".";
      display: block;
      height: 0;
      font-size: 0;
      clear: both;
      visibility: hidden;
    }

    #city-search .homesearch-list {
      border-top: #cb7e01 solid 1px;
    }

    #city-search .homesearch-list:nth-child(1),
    #city-search .homesearch-list:nth-child(2),
    #city-search .homesearch-list:nth-child(3){
      border-top: 0;
    }

    .week .week-day {
      margin-bottom: 30px;
    }

    .week .week-day dt {
      font-size: 20px;
      font-weight: bold;
      text-align: center;
    }

    .week .week-day dd {
      font-size: 36px;
      font-family: sans-serif;
      text-align: center;
      padding-bottom: 20px;
      font-weight: 400;
      font-family: 'Merriweather', serif;
      letter-spacing: 0.1em;
      background: url(images/common/week-day-bg01.gif) top 18px left 200px no-repeat, url(images/common/week-day-bg01.gif) top 18px right 200px no-repeat, url(images/common/week-day-bg02.gif) center bottom 0px no-repeat;
    }

    .week .week-map {
      margin-bottom: 30px;
    }

    .week .week-map #map-result {
      height: 240px;
      width: 100%;
    }

    @media only screen and (max-width: 640px) {

      .homesearch .homesearch-list {
        width: 33.1%;
        font-size: 14px;
      }

      .homesearch .homesearch-list a {
        padding: 10px 0px;
      }

      .homesearch .homesearch-list a img {
        width: 40%;
      }

      .week .week-day dt {
        font-size: 14px;
      }

      .week .week-day dd {
        font-size: 28px;
        background: url(images/common/week-day-bg01.gif) top 11px left -60px no-repeat, url(images/common/week-day-bg01.gif) top 11px right -60px no-repeat, url(images/common/week-day-bg02.gif) center bottom 0px no-repeat;
      }
    }
  </style>
</home>
