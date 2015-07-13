<fes-detail>
  <article if={ fes != null }>
    <div class="main">
      <div class="main-img">
        <img src="images/home/main.jpg" alt="千葉市お祭りデータセンター">
      </div>
    </div>
    <article class="content">
      <div class="info-area">
        <div each={ period, i in fes.periods }>
          <span class="date">{moment(period.start).format('MM/DD')}</span>
          <span class={day-of-week:true,sat:6===period.start.getDay(),sun:0===period.start.getDay()}>{moment(period.start).format('dd')}</span>
          <i class="fa fa-clock-o"></i>
          <span>{moment(period.start).format('HH:mm')}</span>
          <span> - </span>
          <span>{moment(period.end).format('HH:mm')}</span>
        </div>
        <h4 class="detail-title">{fes.name}</h4>
        <div class="features">
          <i if={fes.features.dancing} class="fa fa-star fa-3x"></i>
          <i if={fes.features.singing} class="fa fa-microphone fa-3x"></i>
          <i if={fes.features.drum} class="fa fa-neuter fa-3x"></i>
          <i if={fes.features.musicalPerformance} class="fa fa-music fa-3x"></i>
          <i if={fes.features.foodTruck} class="fa fa-cutlery fa-3x"></i>
          <i if={fes.features.fireworks} class="fa fa-fire fa-3x"></i>
        </div>
        <table class="fes-infos">
          <tbody>
          <tr>
            <th><span class="title-frame">会場</span></th>
            <td>{fes.location.name}</td>
          </tr>
          <tr>
            <th><span class="title-frame">備考</span></th>
            <td>{fes.location.name}</td>
          </tr>
          </tbody>
        </table>
      </div>
      <div id="map-detail"></div>
      <div  class="around-fes-area">
        <div class="title">周辺のお祭り</div>
        <fes-list feslist={aroundFes}></fes-list>
      </div>
    </article>
  </div>
  <script>
    var self = this;
    /** 祭り情報 */
    self.fes = null;
    /** 周辺の祭り */
    self.aroundFes = [];

    /**
     * 地図の生成
     **/
    var marker = null;
    var map = L.map(self["map-detail"], {
      dragging: false
    });
    L.tileLayer("http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png", {
      maxZoom: 18,
      subdomains: ["otile1", "otile2", "otile3", "otile4"],
      attribution: 'Tiles courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">. Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'
    }).addTo(map);
//    L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
//      maxZoom: 18,
//      attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
//      opacity: 0.8
//    }).addTo(map);

    /**
     * 詳細画面表示時
     */
    riot.route.on('routeChange:detail', function(fesId){
      cfc.Event.findOne(fesId).done(function(fes){
        self.fes = fes;
        self.update();

        marker && map.removeLayer(marker);
        marker = L.marker([fes.location.lat, fes.location.long]);
        marker.addTo(map);

        map.setView([fes.location.lat, fes.location.long], 14);

        self.searchAroundRes(fes);
      });
    });

    /**
     * 指定した祭りの周辺の祭り情報を検索します
     */
    searchAroundRes(fes){
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

    // 祭り選択時
    onSelectFes(e){
      //map.panTo(new L.LatLng(e.item.fes.coordinates[1], e.item.fes.coordinates[0]));
      riot.route("detail/" + e.item.fes.id);
    }
  </script>

  <style scoped>

    .info-area {
      padding: 10px;
    }

    /* 開催時刻 */
    .date {
      font-size: 20px;
    }

    .day-of-week {
      margin-left: 5px;
      margin-right: 10px;
    }

    .day-of-week.sat {
      color: #0000ff;
    }

    .day-of-week.sun {
      color: #ff0000;
    }

    .fa.fa-clock-o{
      margin-right: 5px;
    }

    /* 詳細画面タイトル */
    .detail-title {
      color: #E39727;
      font-weight: bold;
    }

    /** 祭り内容 */
    .features .fa {
      border: solid 3px;
      width: 50px;
      height: 50px;
      border-radius: 25px;
      text-align: center;
      margin-right: 5px;
      color: #34AAE8;
    }

    .fes-infos {
      margin-top: 5px;
      width: 100%;
    }

    .fes-infos th {
      width: 100px;
      text-align: center;
    }

    .fes-infos th .title-frame{
      border: solid 1px #000000;
      font-size: x-small;
      padding: 1px 15px;
      border-radius: 10px;
    }

    .fes-infos th, .fes-infos td {
      padding: 5px;
    }

    /** 地図 */
    #map-detail {
      height: 150px;
      width: 100%;
    }

    /** 周辺の祭り */
    .around-fes-area .title {
      background-color: #F4A838;
      color: #ffffff;
      padding: 5px;
    }
  </style>
</fes-detail>
