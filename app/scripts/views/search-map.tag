<search-map>
  <fes-map feslist={feslist}></fes-map>

  <script>
    var self = this;

    this.feslist = [];

    /**
     * 地図画面表示時
     */
    riot.route.on('search/map', function(param){
      self.tags["fes-map"].trigger("show");
      var searchParam = {
        fromDate: param.fromDate ? new Date(param.fromDate) : null,
        toDate: param.toDate ? new Date(param.toDate) : null,
        cities: param.cities,
      };
      cfc.Event.find(searchParam).done(function(res){
        self.feslist = res.list;
        self.update();
      });
    });
  </script>

  <style scoped>
    #map-result { height: 500px; }
  </style>
</search-map>
