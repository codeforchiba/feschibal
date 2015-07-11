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
        data.date = _.map(data.date, function (eventDate) {
          eventDate.start = new Date(eventDate.start);
          eventDate.end = new Date(eventDate.end);
          return eventDate;
        });
        this.dataStore[data.id] = new cfc.Event(data);
      }, this);
    }
  };

  _.defaults(EventStore.prototype,  cfc.StoreBase.prototype);

  nm.EventStore = EventStore;
})(window.cfc = window.cfc || {});
