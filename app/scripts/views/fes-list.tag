<fes-list>
  <div class="row">
    <div class="col-lg-3">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>検索結果：{result.total} 件中 { result.total ? result.limit * result.pageNo + 1 : 0} - {result.limit * result.pageNo + result.list.length} 件</th>
          </tr>
        </thead>
        <tbody>
          <tr each={ fes, i in result.list } onclick={parent.onSelectFes}>
            <td>
              <div>
                <span each={ date, j in fes.date }>
                  <span if={ j > 0 }>, </span>
                  {moment(date.start).format('YYYY/MM/DD')}
                </span>
              </div>
              <div>{fes.name}</div>
            </td>
          </tr>
        </tbody>
      </table>
      <pager result={result} listener={listener}></pager>
    </div>
    <div class="col-lg-9" id="map"></div>
  </div>

  <script>
    var self = this;

    // 検索結果
    this.result = {};
    // 検索条件
    this.searchParam = {};
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

    function setCurrentCoordinates(latitude, longitude){
      map = L.map($mapEl[0]).setView([latitude,longitude], 12);
      tile.addTo(map);
      map.addLayer(markers);

      // Put the Pointer Icon
      var centerPointerIcon = L.icon({
        iconUrl: 'images/icon_pointer.png',
        iconRetinaUrl: 'images/icon_pointer.png',
        iconSize: [35, 35],
        iconAnchor: [17, 17],
        popupAnchor: [0, 0]
      });
      var optionIcon = {
        icon: centerPointerIcon,
        clickable: false,
        draggable: false,
        opacity: 0.9
      }
      L.marker([latitude,longitude] , optionIcon ).addTo(map);
    }

    var $mapEl = $(this.map);
    var checkVisible = setInterval(function(){
      if(!$mapEl.length || !$mapEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      // Get the current location
      if(navigator.geolocation){
        navigator.geolocation.getCurrentPosition(
          function(position){ // success
            setCurrentCoordinates(position.coords.latitude, position.coords.longitude);
          },
          function(error){ // error
            setCurrentCoordinates(35.6098733, 140.1138984);
          },
          {
          "enableHighAccuracy": true,
          "timeout": 8000,
          "maximumAge": 0
          }
        );
      } else { // not correspond to the Geolocation API
        setCurrentCoordinates(35.6098733, 140.1138984);
      }
    },50);

    // 祭り選択時
    onSelectFes(e){
      //map.panTo(new L.LatLng(e.item.fes.coordinates[1], e.item.fes.coordinates[0]));
      opts.listener.onSelectFes(e.item.fes);
    }

    /**
     * 一覧画面表示時
     */
    riot.route.on('search/list', function(param){
      self.searchParam = {
        limit: 10,
        pageNo: param.pageNo || 0,
        fromDate: param.fromDate ? new Date(param.fromDate) : null,
        toDate: param.toDate ? new Date(param.toDate) : null
      };
      cfc.Event.find(self.searchParam).done(updateResult);
    });

    /**
     * 一覧ページ変更時
     */
    this.listener = {
      onPageChange : function(pageNo){
        var fromDate = self.searchParam.fromDate;
        var toDate = self.searchParam.toDate;
        var param = {
          fromDate :  fromDate ? moment(fromDate).format("YYYY-MM-DD") : null,
          toDate : toDate ? moment(toDate).format("YYYY-MM-DD") : null,
          pageNo : pageNo
        };
        riot.route("search/list?" + $.param(param));
      }
    }

    /**
     * 検索結果による画面更新
     *
     * @param res
     */
    var updateResult = function(res){
      self.result = res;
      self.update();

      // 祭りデータから地図のマーカーデータを生成します。
      markers.clearLayers();
      _.each(res.list, function(fes){
        var marker = L.marker(new L.LatLng(fes.location.lat, fes.location.long)).bindLabel(fes.name, { noHide: true, clickable: true });
        marker.on('click', function (e) {
          opts.listener.onSelectFes(fes);
        });
        marker.label.on('click', function (e) {
          opts.listener.onSelectFes(fes);
        });
        markers.addLayer(marker);
      });
    };
  </script>

  <style>
    #map { height: 500px; }
  </style>
</fes-list>
