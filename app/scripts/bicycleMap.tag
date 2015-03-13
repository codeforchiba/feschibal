<bicycle-map>
  <div id="map"></div>

  <script>
    /**
     * 地図を生成して返します。
     */
    var createMap = function(element) {
      /* Basemap Layers */
      var gsiStd = L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
          maxZoom: 18,
          attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
          opacity: 0.8
        }
      );
      var gsiPale = L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png", {
          maxZoom: 18,
          attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
          opacity: 0.8
        }
      );

      var bicycle_lane = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#00ffff",
            fill: false,
            weight: 3,
            opacity: 1,
            clickable: false
          };
        }
      });
      $.getJSON("data/01_chiba_city_bicycle_lane.geojson", function (data) {
        bicycle_lane.addData(data);
      });
      var bicyclemap_blueline = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#0000ff",
            fill: false,
            weight: 3,
            opacity: 1,
            clickable: false
          };
        }
      });
      $.getJSON("data/11_chiba_city_bicyclemap_blueline.geojson", function (data) {
        bicyclemap_blueline.addData(data);
      });
      var bicyclemap_greenline = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#00ff00",
            fill: false,
            weight: 3,
            opacity: 1,
            clickable: false
          };
        }
      });
      $.getJSON("data/12_chiba_city_bicyclemap_greenline.geojson", function (data) {
        bicyclemap_greenline.addData(data);
      });
      var bicyclemap_pinkline = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#ff00ff",
            fill: false,
            weight: 3,
            opacity: 1,
            clickable: false,
            dashArray: "5,5"
          };
        }
      });
      $.getJSON("data/14_chiba_city_bicyclemap_pinkline.geojson", function (data) {
        bicyclemap_pinkline.addData(data);
      });
      var bicyclemap_orengeline = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#ff9900",
            fill: false,
            weight: 3,
            opacity: 1,
            clickable: false,
            dashArray: "5,5"
          };
        }
      });
      $.getJSON("data/15_chiba_city_bicyclemap_orengeline.geojson", function (data) {
        bicyclemap_orengeline.addData(data);
      });

      var contour_10_layer = L.geoJson(null, {
        style: function (feature) {
          return {
            color: "#1f78b4",
            fill: false,
            weight: 1,
            opacity: 0.8,
            clickable: false
          };
        }
      });

      /* Empty layer placeholder to add to layer control for listening when to add/remove theaters to markerClusters layer */
      var bicycleShopLayer = L.geoJson(null);
      var bicycleShop = L.geoJson(null, {
        pointToLayer: function (feature, latlng) {
          return L.marker(latlng, {
            icon: L.icon({
              iconUrl: "http://umap.openstreetmap.fr/uploads/pictogram/bicycle-24.png",
              iconSize: new L.Point(30, 30),
              opacity: 1
            }),
            title: feature.properties.name
          });
        },
        onEachFeature: function (feature, layer) {
          if (feature.properties) {
            var content = "<table class='table table-striped table-bordered table-condensed'>" + "<tr><th>Name</th><td>" + feature.properties.name + "</td></tr>" + "<table>";
            layer.on({
              click: function (e) {
                $("#feature-title").html(feature.properties.name);
                $("#feature-info").html(content);
                $("#featureModal").modal("show");
                //highlight.clearLayers().addLayer(L.circleMarker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], highlightStyle));
              }
            });
          }
        }
      });
      $.getJSON("data/bicycle_shop_map.geojson", function (data) {
        bicycleShop.addData(data);
        bicycleShop.addTo(bicycleShopLayer);
        //map.addLayer(bicycleShopLayer);
      });

      /* Empty layer placeholder to add to layer control for listening when to add/remove museums to markerClusters layer */
      var parkingLayer = L.geoJson(null);
      var parkings = L.geoJson(null, {
        pointToLayer: function (feature, latlng) {
          return L.marker(latlng, {
            icon: L.icon({
              iconUrl: "images/bicycle_parking.svg",
              iconSize: [30, 30]
            }),
            title: feature.properties.name
          });
        },
        onEachFeature: function (feature, layer) {
          if (feature.properties) {
            var content = "<table class='table table-striped table-bordered table-condensed'>" + "<tr><th>Name</th><td>" + feature.properties.name + "</td></tr>" + "<tr><th>住所</th><td>" + feature.properties.address + "</td></tr>" + "<tr><th>一時利用最大台数</th><td>" + feature.properties.capacity + "台" + "</td></tr>" + "<table>";
            layer.on({
              click: function (e) {
                $("#feature-title").html(feature.properties.name);
                $("#feature-info").html(content);
                $("#featureModal").modal("show");
                //highlight.clearLayers().addLayer(L.circleMarker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], highlightStyle));
              }
            });
          }
        }
      });
      $.getJSON("data/parking.geojson", function (data) {
        parkings.addData(data);
        parkings.addTo(parkingLayer);
        //map.addLayer(parkingLayer);
      });

      var busStopLayer = L.geoJson(null);
      var busStop = L.geoJson(null, {
        pointToLayer: function (feature, latlng) {
          return L.marker(latlng, {
            icon: L.icon({
              iconUrl: "images/bus-18.png",
              iconSize: new L.Point(18, 18),
              opacity: 1
            }),
            title: feature.properties.name
          });
        },
        onEachFeature: function (feature, layer) {
          if (feature.properties) {
            var content = "<table class='table table-striped table-bordered table-condensed'>" + "<tr><th>Name</th><td>" + feature.properties.P11_001 + "</td></tr>" + "<table>";
            layer.on({
              click: function (e) {
                $("#feature-title").html(feature.properties.P11_001);
                $("#feature-info").html(content);
                $("#featureModal").modal("show");
                //highlight.clearLayers().addLayer(L.circleMarker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]], highlightStyle));
              }
            });
          }
        }
      });
      $.getJSON("data/bus_stop.geojson", function (data) {
        busStop.addData(data);
        busStop.addTo(busStopLayer);
        //map.addLayer(busStopLayer);
      });


      var map = L.map(element, {
        zoom: 10,
        center: [35.600252, 140.098042],
        layers: [gsiStd, bicycle_lane, bicyclemap_blueline, bicyclemap_greenline, bicyclemap_pinkline, bicyclemap_orengeline],
        zoomControl: false,
        attributionControl: false
      });

      var zoomControl = L.control.zoom({
        position: "bottomright"
      }).addTo(map);

      /* GPS enabled geolocation control set to follow the user's location */
      var locateControl = L.control.locate({
        position: "bottomright",
        drawCircle: true,
        follow: true,
        setView: true,
        keepCurrentZoomLevel: true,
        markerStyle: {
          weight: 1,
          opacity: 0.8,
          fillOpacity: 0.8
        },
        circleStyle: {
          weight: 1,
          clickable: false
        },
        icon: "icon-direction",
        metric: false,
        strings: {
          title: "My location",
          popup: "You are within {distance} {unit} from this point",
          outsideMapBoundsMsg: "You seem located outside the boundaries of the map"
        },
        locateOptions: {
          maxZoom: 18,
          watch: true,
          enableHighAccuracy: true,
          maximumAge: 10000,
          timeout: 10000
        }
      }).addTo(map);

      /* Larger screens get expanded layer control and visible sidebar */
      if (document.body.clientWidth <= 767) {
        var isCollapsed = true;
      } else {
        var isCollapsed = false;
      }

      var baseLayers = {
        "地理院タイル標準地図": gsiStd,
        "地理院タイル淡色地図": gsiPale
      };

      var groupedOverlays = {
        "Points of Interest": {
          "駐車場": parkingLayer,
          "自転車屋": bicycleShopLayer,
          "バス停": busStopLayer
        },
        "走りやすさ": {
          "自転車用道路": bicycle_lane,
          "○": bicyclemap_blueline,
          "△": bicyclemap_greenline,
          "笨普@幅の広い歩道なし": bicyclemap_pinkline,
          "笨普@幅の広い歩道あり": bicyclemap_orengeline
        }/* ,
         "地形": {
         "等高線(10m)": contour_10_layer
         }*/
      };

      var layerControl = L.control.groupedLayers(baseLayers, groupedOverlays, {
        collapsed: isCollapsed
      }).addTo(map);

      return map;
    }

    var map = null;
    var $mapElement = $(this.map);
    var $leafletControlLayers;

    /**
     * Domが描画された時の処理
     * @type {number}
     */
    var checkVisible = setInterval(function(){
      if(!$mapElement.length || !$mapElement.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      map = createMap($mapElement[0]);
      map.fitBounds([
        [35.663033164341684, 140.10839983820915],
        [35.6042355897768, 140.02212926745415]
      ]);

      $leafletControlLayers = $(".leaflet-control-layers");
      var container = $leafletControlLayers[0];
      if (!L.Browser.touch) {
        L.DomEvent
          .disableClickPropagation(container)
          .disableScrollPropagation(container);
      } else {
        L.DomEvent.disableClickPropagation(container);
      }
    },50);

    var sizeLayerControl = function() {
      $leafletControlLayers && $leafletControlLayers.css("max-height", $mapElement.height() - 50);
    }

    $(document).one("ajaxStop", function () {
      sizeLayerControl();
    });

    $(window).resize(function() {
      sizeLayerControl();
    });

    opts.mapctr.on('resize', function(){
      map.invalidateSize();
    });

  </script>
</bicycle-map>
