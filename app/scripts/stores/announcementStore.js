(function (nm) {
  'use strict';
  /**
   * お知らせデータストア
   *
   * @constructor
   */
  var AnnouncementStore = function () {

  };

  AnnouncementStore.prototype = {
    /** アクセス先URL */
    url: '@@url.announcement',

    storeData: function(dataList){
      _.each(dataList, function (data) {
        data.id = moment(data.postedAt).format('YYYYMMDD');
        this.dataStore[data.postedAt] = new cfc.Announcement(data);
      }, this);
    }
  };

  _.defaults(AnnouncementStore.prototype,  cfc.StoreBase.prototype)

  nm.AnnouncementStore = AnnouncementStore;
})(window.cfc = window.cfc || {});
