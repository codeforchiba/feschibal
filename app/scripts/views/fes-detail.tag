<fes-detail>
  <div if={ fes != null }>
    <div class="main">
      <div class="main-img">
        <img id="header-img" src="images/festival/{fes.id}/header.jpg" alt="千葉市お祭りデータセンター">
      </div>
    </div>
    <article class="content">
      <div class="info-area">
        <h4 class="detail-title">{fes.name}</h4>
        <ul class="day-time">
          <li each={ period, i in fes.periods }>
            <span class="date">{moment(period.start).format('MM/DD')}</span>
            <span class={day-of-week:true,sat:6===period.start.getDay(),sun:0===period.start.getDay()}>{moment(period.start).format('dd')}</span>
            <span class="clock">
              <span if={moment(period.start).format('HH:mm') != '00:00'}>{moment(period.start).format('HH:mm')}</span>
              <span if={moment(period.end).format('HH:mm') != '00:00'}> - {moment(period.end).format('HH:mm')}</span>
            </span>
          </li>
        </ul>
        <div class="weather" if={moment(fes.getEndDate()).isSameOrAfter(moment(),'day')}>
          <ul>
            <li each={ period, i in fes.periods }>
              <div class="left-weather">
                <div class="date">{moment(period.start).format('MM/DD')}</div>
                <div>
                  <span if={period.weather.weatherCode != null } class="icon-weather c{period.weather.weatherCode}"></span>
                  <span if={period.weather == null || period.weather.weatherCode == null } class="icon-weather none"></span>
                </div>
              </div>
              <div class="right-weather">
                <div>
                  <span if={period.weather.weather != null }>{period.weather.weather}</span>
                  <span if={period.weather == null || period.weather.weather == null}>--</span>
                </div>
                <div>
                  <span if={period.weather.temperatureMax != null } class="temperatureMax">{period.weather.temperatureMax}</span>
                  <span if={period.weather == null || period.weather.temperatureMax == null}>--</span>
                  /
                  <span if={period.weather.temperatureMin != null } class="temperatureMin">{period.weather.temperatureMin}</span>
                  <span if={period.weather == null || period.weather.temperatureMin == null}>--</span>
                </div>
                <div>
                  <span if={period.weather.precipitation != null }>{period.weather.precipitation}%</span>
                  <span if={period.weather == null || period.weather.precipitation == null}>--</span>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="features">
          <img if={fes.features.dancing} src="images/detail/Detail_icon01.svg" />
          <img if={fes.features.singing} src="images/detail/Detail_icon02.svg" />
          <img if={fes.features.drum} src="images/detail/Detail_icon03.svg" />
          <img if={fes.features.musicalPerformance} src="images/detail/Detail_icon04.svg" />
          <img if={fes.features.foodTruck} src="images/detail/Detail_icon05.svg" />
          <img if={fes.features.fireworks} src="images/detail/Detail_icon06.svg" />
          <img if={fes.features.mikoshi} src="images/detail/Detail_icon07.svg" />
        </div>

        <dl class="fes-infos">
        <dt>会　場</dt>
        <dd>{fes.location.name}</dd>
        <dt>住　所</dt>
        <dd>{fes.location.city}{fes.location.address}</dd>
        <dt>内　容</dt>
        <dd>
          <ul>
            <li>
              <span if={fes.features.dancing}>踊り　</span><span if={fes.features.singing}>歌唱　</span><span if={fes.features.drum}>太鼓　</span>
              <span if={fes.features.musicalPerformance}>演奏　</span><span if={fes.features.foodTruck}>屋台　</span><span if={fes.features.fireworks}>花火　</span>
              <span if={fes.features.mikoshi}>神輿　</span>
            </li>
            <li each={ program in fes.features.others }>{program}</li>
            <li each={ program in fes.features.specialProgram }>{program}</li>
          </ul>
        </dd>
        <dt>URL</dt>
        <dd><a href={fes.url} target="_blank">{fes.url}</a></dd>
        <dt>備　考</dt>
        <dd>{fes.remarks}</dd>
        </dl>
        <div class="img-area">
        <span each={ imageUrl, i in imageUrls }>
          <a href="{imageUrl}"data-lightbox="festival-image">
            <img src="{imageUrl}" alt="祭り画像">
          </a>
        </span>
        </div>
      </div>
      <div id="map-detail"></div>
      <div class="title">周辺のお祭り</div>
      <fes-list feslist={aroundFes}></fes-list>
    </article>
  </div>
  <script>
    var self = this;
    /** 祭り情報 */
    self.fes = null;
    /** 周辺の祭り */
    self.aroundFes = [];
    /** 祭り画像 */
    self.imageUrls = [];

    /**
     * タイトル画像がなければデフォルトの画像を表示
     */
    $(self["header-img"]).error(function(){
      $(this).attr({
        src: 'images/home/main.jpg'
      });
    });

    /**
     * 地図の生成
     **/
    var marker = null;
    var map = L.map(self["map-detail"], {
      dragging: true
    });
    L.tileLayer("https://tile.openstreetmap.jp/{z}/{x}/{y}.png", {
      maxZoom: 18,
      attribution: 'Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'
    }).addTo(map);

    /**
     * 詳細画面表示時
     */
    riot.route.on('routeChange:detail', function(fesId){
      cfc.Event.findOne(fesId).done(function(fes){
        self.fes = fes;
        self.update();

        marker && map.removeLayer(marker);
        var icon = L.icon({
          iconUrl: 'images/marker-icon.png',
          iconSize: [30, 40]
        });
        marker = L.marker([fes.location.lat, fes.location.long], {icon: icon});
        marker.addTo(map);

        map.setView([fes.location.lat, fes.location.long], 14);

        // 周辺の祭り取得
        self.fetchAroundRes(fes);
        // 天気予報取得
        self.fetchWeather(fes);
        // 祭りに関する画像を取得
        self.fetchImages(fes);
      });
    });

    /**
     * 指定した祭りの周辺の祭り情報を取得します
     */
    fetchAroundRes(fes){
      var latLng = L.latLng([fes.location.lat, fes.location.long]);
      var param = {
        fromDate : new Date(),
        basePoint: latLng,
        distance: 5000,
        limit: 10,
        pageNo: 0,
        order: "periods"
      };
      cfc.Event.find(param).done(function(res){
        // 距離での絞り込み結果から自分自身の祭りを除外する
        self.aroundFes = _.filter(res.list, function(_fes){
          return fes.id !== _fes.id;
        });
        self.update();
      });
    }

    /**
     * 指定した祭りの開催日の天気を取得します。
     */
    fetchWeather(fes){
      _.each(fes.periods, function(period){
        cfc.Weather.findByDate(period.start).done(function(weather) {
          period.weather = weather;
          self.update();
        });
      });
    }

    /**
     * 指定した祭りに関連する画像を取得
     */
    fetchImages(fes){
      self.imageUrls = [];
      self.fetchImage(fes.id, 1);
    }

    fetchImage(fesId, index){
      var img = new Image();
      var indexStr = String(index);
      indexStr.length === 1 && (indexStr = "0" + indexStr);
      var url = 'images/festival/' + fesId + '/item_' + indexStr + '.jpg';
      img.onload = function() {
        self.imageUrls.push(url);
        self.fetchImage(fesId, index + 1);
      };
      img.onerror = function() {
        self.update();
      };
      img.src = url;
    }

    // 祭り選択時
    onSelectFes(e){
      //map.panTo(new L.LatLng(e.item.fes.coordinates[1], e.item.fes.coordinates[0]));
      riot.route("detail/" + e.item.fes.id);
    }
  </script>

  <style scoped>
    .info-area {
      margin-left: 10px;
      margin-right: 10px;
    }

    /* 詳細画面タイトル */
    .detail-title {
      color: #E39727;
      font-weight: bold;
      font-size: 46px;
      line-height: 1.2em;
      margin-bottom: 20px;
    }

    /** 開催時刻 */
    .info-area .day-time {
      border-top: 1px solid #ccc;
      border-bottom: 1px solid #ccc;
      padding-bottom: 20px;
      padding-top: 20px;
    }
    .info-area .day-time li {
      float: left;
      margin-right: 30px;
    }
    .info-area .day-time .date {
      font-size: 26px;
      font-family: 'Merriweather', serif;
      font-weight: 400;
      margin-right: 8px;
    }
    .info-area .day-time .day-of-week {
      font-size: 18px;
      margin-right: 10px;
    }
    .info-area .day-time .sat {
      color: #3aa3e6;
    }
    .info-area .day-time .sun {
      color: #E10003;
    }
    .info-area .day-time .clock {
      font-family: "Times New Roman", Times, serif;
      font-size: 24px;
    }
    .info-area .day-time:after {
      content: ".";
      display: block;
      height: 0;
      font-size: 0;
      clear: both;
      visibility: hidden;
    }

    /** 天気予報 */
    .info-area .weather {
      border-bottom: 1px solid #ccc;
      margin-bottom: 30px;
      padding-bottom: 20px;
      padding-top: 20px;
    }
    .info-area .weather ul:after {
      content: ".";
      display: block;
      height: 0;
      font-size: 0;
      clear: both;
      visibility: hidden;
    }
    .info-area .weather li {
      float: left;
      text-align: center;
      margin-right: 30px;
      display: table;
      height: 80px;
    }

    .info-area .weather .left-weather,
    .info-area .weather .right-weather
    {
      display: table-cell;
      vertical-align: top;
    }
    .info-area .weather .left-weather {
      padding-right: 10px;
    }

    .info-area .weather .temperatureMax {
      font-weight: bold;
      color: #ff3300;
      font-size: 24px;
    }

    .info-area .weather .temperatureMin {
      font-weight: bold;
      color: #0066ff;
      font-size: 24px;
    }

    /** 祭り内容 */
    .info-area .features {
      clear: both;
      margin-bottom: 30px;
    }
    .info-area .features img {
      width: 120px;
    }

    /** 祭り情報 */
    .info-area .fes-infos {
      clear: both;
    }
    .info-area .fes-infos dt {
      float: left;
      border: solid 1px #A0A0A0;
      font-size: 18px;
      padding: 1px 30px;
      border-radius: 10px;
      clear: left;
      margin-bottom: 20px;
    }
    .info-area .fes-infos dd {
      padding-left: 120px;
      margin-bottom: 20px;
      font-size: 16px;
      min-height: 29px;
    }

    /** 祭り画像 */
    .info-area .img-area {
      clear: both;
    }
    .info-area .img-area img {
      width: 120px;
      height: 120px;
      border-radius: 4px;
      margin-bottom: 30px;
      margin-right: 30px;
    }

    /** 地図 */
    #map-detail {
      height: 250px;
      width: 100%;
      margin-bottom: 30px;
    }

    /** 周辺の祭り */
    .content .title {
      background-color: #F4A838;
      color: #ffffff;
      padding: 10px;
      font-size: 24px;
      margin-bottom: 30px;
    }

    @media only screen and (max-width: 640px) {
      .info-area .detail-title {
        font-size: 28px;
      }
      .info-area .features img {
        width: 33.3%;
      }
      .info-area .fes-infos dt {
        float: none;
        text-align: center;
        margin-bottom: 10px;
      }
      .info-area .fes-infos dd {
        padding-left: 0px;
      }
    }
  </style>
</fes-detail>
