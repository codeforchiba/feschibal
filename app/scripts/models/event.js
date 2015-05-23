(function(nm){
  /**
   * 祭りイベントオブジェクト
   *
   * @constructor
   */
  var Event = function(data){
    for(var prop in data){
      this[prop] = data[prop];
    }
  };

  Event.prototype = {

  };

  /**
   * データストア
   */
  Event.dataStore = new cfc.EventStore();

  /**
   * 全データを返すJQueryDeferrdを返します。
   *
   * @return JQueryDeferred
   */
  Event.findAll = function(){
    return this.dataStore.findAll();
  }

  /**
   * 指定された検索条件に絞り込んだデータを返すJQueryDeferrdを返します。
   * @param param
   *  @param.limit {Number} 上限件数
   *  @param.pageNo {Number} 指定上限件数でのページ番号
   *  @param.startDate {Date} 開始日付
   *  @param.endDate {Date} 終了日付
   */
  Event.find = function(param){
    return this.findAll().then(function(fesList){
      // 検索条件による絞込み
      return _.filter(fesList, function(fes){
        if(param.startDate){
          var isInclude = _.some(fes.date, function(date){
            return date.end.getTime() > param.startDate.getTime();
          });
          if(!isInclude){
            return false;
          }
        }
        if(param.endDate){
          var isInclude = _.some(fes.date, function(date){
            return date.start.getTime() < param.endDate.getTime();
          });
          if(!isInclude){
            return false;
          }
        }
        return true;
      });
    }).then(function(fesList){
      // ページング機能による絞込み
      var startIndex = param.limit * param.pageNo;
      var endIndex = param.limit * (param.pageNo + 1 );
      return {
        total: fesList.length,
        limit: param.limit,
        pageNo: param.pageNo,
        list:_.filter(fesList, function(fes, index){
          return startIndex <= index && endIndex >= index;
        })
      }
    });
  }

  nm.Event = Event;
})(window.cfc = window.cfc || {});
