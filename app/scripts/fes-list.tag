<fes-list>
  <div class="row">
    <div class="col-lg-3">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>検索結果：100 件中 1-10 件</th>
          </tr>
        </thead>
        <tbody>
          <tr each={ fes, i in fesList } onclick={parent.onSelectFes}>
            <td>
              <div>{fes.start}</div>
              <div>{fes.name}</div>
            </td>
          </tr>
        </tbody>
      </table>
      <nav>
        <ul class="pager">
          <li class="previous disabled"><a href="javascript:void(0);"><span aria-hidden="true">&larr;</span> 前へ</a></li>
          <li class="next"><a href="javascript:void(0);">次へ <span aria-hidden="true">&rarr;</span></a></li>
        </ul>
      </nav>
    </div>
    <div class="col-lg-9" id="map"></div>
  </div>

  <script>
    var self = this;

    // 祭り一覧
    self.fesList = [];

    // データロード時
    opts.request.on('loaded', function(fesList){
      self.fesList = fesList;

      // 祭りデータから地図のマーカーデータを生成します。
      var data = {
        "type": "FeatureCollection",
        "features": []
      };
      data.features = _.map(fesList, function(fes){
        return {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": fes.coordinates
          },
          "properties": fes
        }
      });

      markerList.addData(data);
    });

    // 地図情報
    var map;

    // 地図タイル
    var tile = L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
      maxZoom: 18,
      attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
      opacity: 0.8
    });

    // マーカー一覧(geoJson)
    var markerList = L.geoJson(null, {
      pointToLayer: function (feature, latlng) {
        return L.marker(latlng).bindLabel(feature.properties.name, { noHide: true });
      },
      onEachFeature: function (feature, layer) {
        //opts.listener.onSelectFes(feature.properties);
      }
    })

    var $mapEl = $(this.map);
    var checkVisible = setInterval(function(){
      if(!$mapEl.length || !$mapEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      var map = L.map($mapEl[0]).setView([35.6098733,140.1138984], 13);
      tile.addTo(map);
      markerList.addTo(map);

    },50);

    // 祭り選択時
    onSelectFes(e){
      opts.listener.onSelectFes(e.item.fes);
    }
  </script>

  <style>
    #map { height: 500px; }
  </style>
</fes-list>
