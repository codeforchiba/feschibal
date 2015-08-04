<fes-map>
  <div id="map-result"></div>

  <script>
    /**
     * 地図の生成
     **/
    var map = L.map(this["map-result"], {
      dragging: true
    });
    L.tileLayer("http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png", {
      maxZoom: 18,
      subdomains: ["otile1", "otile2", "otile3", "otile4"],
      attribution: 'Tiles courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">. Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'
    }).addTo(map);
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
        iconUrl: 'images/icon_pointer_360.png',
        iconRetinaUrl: 'images/icon_pointer_360.png',
        iconSize: [50, 50],
        iconAnchor: [25, 25],
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

    this.on('show', function() {
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

    this.on('update', function() {
      // 祭りデータから地図のマーカーデータを生成します。
      markers.clearLayers();
      var icon = L.icon({
        iconUrl: 'images/marker-icon.png',
        iconSize: [30, 40]
      });
      _.each(opts.feslist, function(fes){
        var marker = L.marker(new L.LatLng(fes.location.lat, fes.location.long), {icon: icon}).bindLabel(fes.name, { noHide: true, clickable: true });
        marker.on('click', function (e) {
          riot.route("detail/" + fes.id);
        });
        marker.label.on('click', function (e) {
          riot.route("detail/" + fes.id);
        });
        markers.addLayer(marker);
      });
    });
  </script>

  <style scoped>

  </style>
</fes-map>
