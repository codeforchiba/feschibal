<fes-map>
  <div id="map-search"></div>

  <script>
    var self = this;

    /**
     * 地図の生成
     **/
    var map = L.map(self["map-search"], {
      dragging: true
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
    // マーカー一覧(geoJson)
    var markers = L.markerClusterGroup();
    markers.addTo(map);

    /**
     * 現在地を設定
     */
    function setCurrentCoordinates(latitude, longitude){
      map.setView([latitude,longitude], 12);

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

    /**
     * 地図画面表示時
     */
    riot.route.on('search/map', function(param){
      var searchParam = {
        fromDate: param.fromDate ? new Date(param.fromDate) : null,
        toDate: param.toDate ? new Date(param.toDate) : null
      };
      cfc.Event.find(searchParam).done(updateResult);

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
    });

    /**
     * 検索結果による画面更新
     *
     * @param res
     */
    var updateResult = function(res){

      // 祭りデータから地図のマーカーデータを生成します。
      markers.clearLayers();
      _.each(res.list, function(fes){
        var marker = L.marker(new L.LatLng(fes.location.lat, fes.location.long)).bindLabel(fes.name, { noHide: true, clickable: true });
        marker.on('click', function (e) {
          riot.route("detail/" + fes.id);
        });
        marker.label.on('click', function (e) {
          riot.route("detail/" + fes.id);
        });
        markers.addLayer(marker);
      });
    };
  </script>

  <style scoped>
    #map-search { height: 500px; }
  </style>
</fes-map>
