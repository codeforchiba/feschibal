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
      self.update();

      // 祭りデータから地図のマーカーデータを生成します。
      markers.clearLayers();
      _.each(fesList, function(fes){
        var marker = L.marker(new L.LatLng(fes.coordinates[1], fes.coordinates[0])).bindLabel(fes.name, { noHide: true, clickable: true });
        marker.on('click', function (e) {
          opts.listener.onSelectFes(fes);
        });
        marker.label.on('click', function (e) {
          opts.listener.onSelectFes(fes);
        });
        markers.addLayer(marker);
      });
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
    var markers = L.markerClusterGroup();

    var $mapEl = $(this.map);
    var checkVisible = setInterval(function(){
      if(!$mapEl.length || !$mapEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      map = L.map($mapEl[0]).setView([35.6098733,140.1138984], 12);
      tile.addTo(map);
      map.addLayer(markers);

    },50);

    // 祭り選択時
    onSelectFes(e){
      map.panTo(new L.LatLng(e.item.fes.coordinates[1], e.item.fes.coordinates[0]));
    }
  </script>

  <style>
    #map { height: 500px; }
  </style>
</fes-list>
