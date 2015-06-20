<fes-detail>
  <div>
    <div>詳細画面</div>
    <button onclick={testMove}>テスト遷移</button>
    <div id="ditail-map"></div>
  </div>
  <script>

    var $mapEl = $(this["detail-map"]);

    /**
     * 詳細画面表示時
     */
    riot.route.onAttached('detail', $mapEl, function(param){
      console.log("detail onAttached");
    });

    /**
     * 詳細画面表示時
     */
    riot.route.on('routeChange:detail', function(fesId){
      console.log("detail routeChange:"+fesId);
      cfc.Event.findOne(fesId).done(function(fes){
        console.log(fes);
      }).fail(function(){
        console.log("no data");
      });
    });

    testMove(){
      riot.route("detail/10");
    }
  </script>

  <style scoped>

  </style>
</fes-detail>
