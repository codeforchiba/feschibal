(function (nm) {
  'use strict';
  /**
   * お知らせオブジェクト
   *
   * @constructor
   */
  var Announcement = function (data) {
    for (var prop in data) {
      this[prop] = data[prop];
    }
  };

  Announcement.prototype = {
  };

  /**
   * データストア
   */
   Announcement.dataStore = new cfc.AnnouncementStore();

  /**
   * 全データを返すJQueryDeferrdを返します。
   *
   * @return JQueryDeferred
   */
  Announcement.findAll = function () {
    return this.dataStore.findAll();
  };

  /**
   * 指定したaddressCodeに該当する地域を返すJQueryDeferrdを返します。
   *
   * @param fesId
   */
  Announcement.findOne = function (addressCode) {
    return this.dataStore.findOne(addressCode);
  }

  nm.Announcement = Announcement;
})(window.cfc = window.cfc || {});
