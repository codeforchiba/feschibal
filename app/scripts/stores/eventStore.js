(function (nm) {
  'use strict';
  /**
   * 祭りイベントデータストア
   *
   * @constructor
   */
  var EventStore = function () {

  };

  EventStore.prototype = {
    /** アクセス先URL */
    url: '@@url.event',

    storeData: function(dataList){
      _.each(dataList, function (data) {
        // 日付をDate型に変換
        data.periods = _.map(data.periods, function (period) {
          period.start = new Date(period.start);
          period.end = new Date(period.end);
          return period;
        });
        this.dataStore[data.id] = new cfc.Event(data);
      }, this);
    }
  };

  _.defaults(EventStore.prototype,  cfc.StoreBase.prototype);

  nm.EventStore = EventStore;
})(window.cfc = window.cfc || {});
