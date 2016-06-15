<home>
  <div class="main">
    <div class="main-img">
      <div class="swiper-container">
        <div class="swiper-wrapper">
          <div class="swiper-slide"><img src="images/home/top.jpg" alt="千葉市お祭りデータセンター"></div>
          <div class="swiper-slide"><img src="images/home/civictech.jpg" alt="MA11 シビックテック部門賞 & MA11 CIVICTECH for Citizen賞 受賞"></div>
          <div class="swiper-slide"><img src="images/home/projectdesign.jpg" alt="月刊事業構想４月号掲載"></div>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        <!-- Add Arrows -->
        <div class="swiper-button-next swiper-button-orange"></div>
        <div class="swiper-button-prev swiper-button-orange"></div>
      </div>
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
    var self = this;

    // 今週開催の祭り一覧
    this.fesList = [];

    // 区一覧
    this.cities = [];

    // 区毎の祭りの件数
    this.fesCount = {"a":"b"};

    // 今週の開始日付と終了日付
    if(moment().weekday() === 0){
      // 日曜日の場合
      this.startDateOfWeek = moment().weekday(-6).toDate();
      this.endDateOfWeek = moment().toDate();
    } else {
      // 日曜日以外の場合
      this.startDateOfWeek = moment().weekday(1).toDate();
      this.endDateOfWeek = moment().weekday(7).toDate();
    }

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
      var param;
      if(moment().weekday() === 0){
        // 日曜日の場合
        param = {
          fromDate: moment().weekday(-1).format("YYYY-MM-DD"),
          toDate: moment().format("YYYY-MM-DD")
        };
      } else {
        // 日曜日以外の場合
        param = {
          fromDate: moment().weekday(6).format("YYYY-MM-DD"),
          toDate: moment().weekday(7).format("YYYY-MM-DD")
        };
      }
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

    /**
     * swiper用
     */
    jQuery(document).ready(function () {
      var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        paginationClickable: true,
        spaceBetween: 30,
        effect: 'fade',
        centeredSlides: true,
        autoplay: 2500,
        autoplayDisableOnInteraction: false
      });
    });
  </script>

  <style scoped>
    .homesearch {
      background: #f5ac42;
      margin-bottom: 30px;
      border-top: 3px solid #fccb83;
      border-bottom: 4px solid #cb7e01;
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

    /**
     * swiper用
     */

    .main .main-img .swiper-container .swiper-wrapper .swiper-slide::before {
      background: url(../images/common/t.svg) no-repeat;
      background-size: cover;
      background-position: center center;
      display: block;
      width: 100%;
      height: 100%;
      content: "";
      position: absolute;
      bottom: 0;
    }

    .swiper-pagination-bullet {
      background-color: #ffffff;
      opacity: 1;
    }

    .swiper-pagination-bullet.swiper-pagination-bullet-active {
      background-color: #e94a1a;
      opacity: 1;
    }

    .swiper-button-prev.swiper-button-disabled,
    .swiper-button-next.swiper-button-disabled {
      opacity: 1;
    }

    .swiper-button-prev.swiper-button-disabled.swiper-button-orange,
    .swiper-container-rtl .swiper-button-next.swiper-button-disabled.swiper-button-orange {
      background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M0%2C22L22%2C0l2.1%2C2.1L4.2%2C22l19.9%2C19.9L22%2C44L0%2C22L0%2C22L0%2C22z'%20fill%3D'%23f3a534'%2F%3E%3C%2Fsvg%3E");
    }

    .swiper-button-prev.swiper-button-orange,
    .swiper-container-rtl .swiper-button-next.swiper-button-orange {
      background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M0%2C22L22%2C0l2.1%2C2.1L4.2%2C22l19.9%2C19.9L22%2C44L0%2C22L0%2C22L0%2C22z'%20fill%3D'%23e94a1a'%2F%3E%3C%2Fsvg%3E");
    }

    .swiper-button-next.swiper-button-disabled.swiper-button-orange,
    .swiper-container-rtl .swiper-button-prev.swiper-button-disabled.swiper-button-orange {
      background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M27%2C22L27%2C22L5%2C44l-2.1-2.1L22.8%2C22L2.9%2C2.1L5%2C0L27%2C22L27%2C22z'%20fill%3D'%23f3a534'%2F%3E%3C%2Fsvg%3E");
    }

    .swiper-button-next.swiper-button-orange,
    .swiper-container-rtl .swiper-button-prev.swiper-button-orange {
      background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D'http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg'%20viewBox%3D'0%200%2027%2044'%3E%3Cpath%20d%3D'M27%2C22L27%2C22L5%2C44l-2.1-2.1L22.8%2C22L2.9%2C2.1L5%2C0L27%2C22L27%2C22z'%20fill%3D'%23e94a1a'%2F%3E%3C%2Fsvg%3E");
    }

    .swiper-button-next,.swiper-button-prev {
      top: 104px;
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

      .swiper-button-prev,.swiper-button-next {
        height: 22px;
        top: 48px;
      }

      .swiper-button-prev {
        left: 4px;
      }

      .swiper-button-next {
        right: 4px;
      }
    }
  </style>
</home>
