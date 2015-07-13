<search-list>
  <div>
    検索結果：{result.total} 件中 { result.total ? result.limit * result.pageNo + 1 : 0} - {result.limit * result.pageNo + result.list.length} 件
  </div>
  <fes-list feslist={result.list}></fes-list>
  <pager result={result} listener={listener}></pager>

  <script>
    var self = this;

    // 検索結果
    this.result = {};
    // 検索条件
    this.searchParam = {};

    // 祭り選択時
    onSelectFes(e){
      //map.panTo(new L.LatLng(e.item.fes.coordinates[1], e.item.fes.coordinates[0]));
      riot.route("detail/" + e.item.fes.id);
    }

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
     * 一覧画面表示時
     */
    riot.route.on('search/list', function(param){
      var searchParam = {
        limit: 10,
        pageNo: param.pageNo || 0,
        fromDate: param.fromDate ? new Date(param.fromDate) : null,
        toDate: param.toDate ? new Date(param.toDate) : null,
        order: "periods"
      };
      cfc.Event.find(searchParam).done(function(res){
        self.result = res;
        self.update();
      });
    });
  </script>

  <style scoped>

  </style>
</search-list>
