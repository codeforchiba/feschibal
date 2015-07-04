(function (nm) {
  'use strict';
  /**
   * 祭りイベントオブジェクト
   *
   * @constructor
   */
  var Event = function (data) {
    for (var prop in data) {
      this[prop] = data[prop];
    }
  };

  Event.prototype = {
    /**
     * 初日の開始日時を返します。
     *
     * @returns {Date} 初日の開始日時
     */
    getStartDate: function () {
      return this.date[0].start;
    },

    /**
     * 最終日の終了日時を返します。
     *
     * @returns {Date} 最終日の終了日時
     */
    getEndDate: function () {
      return this.date[this.date.length - 1].end;
    }
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
  Event.findAll = function () {
    return this.dataStore.findAll();
  };

  /**
   * 指定された検索条件に絞り込んだデータを返すJQueryDeferrdを返します。
   * @param param
   *  @param.limit {Number} 上限件数
   *  @param.pageNo {Number} 指定上限件数でのページ番号
   *  @param.fromDate {Date} 開始日付
   *  @param.toDate {Date} 終了日付
   */
  Event.find = function (param) {
    return this.findAll().then(function (fesList) {
      // 検索条件による絞込み
      return _.filter(fesList, function (fes) {
        var isInclude = false;
        if (param.fromDate) {
          isInclude = _.some(fes.date, function (date) {
            return date.end.getTime() > param.fromDate.getTime();
          });
          if (!isInclude) {
            return false;
          }
        }
        if (param.toDate) {
          isInclude = _.some(fes.date, function (date) {
            return date.start.getTime() < param.toDate.getTime();
          });
          if (!isInclude) {
            return false;
          }
        }

        // 距離による絞込み
        if (param.basePoint && param.distance != null) {
          var latLng = L.latLng([fes.location.lat, fes.location.long]);
          fes.distance = latLng.distanceTo(param.basePoint);
          if (fes.distance > param.distance) {
            return false;
          }
        }

        return true;
      });
    }).then(function (fesList) {
      // ページング機能による絞込み
      if (param.limit != null && param.pageNo != null) {
        var startIndex = param.limit * param.pageNo;
        var endIndex = param.limit * (param.pageNo + 1 ) - 1;
        return {
          total: fesList.length,
          limit: param.limit,
          pageNo: param.pageNo,
          list: _.filter(fesList, function (fes, index) {
            return startIndex <= index && endIndex >= index;
          })
        };
      } else {
        return {
          total: fesList.length,
          list: fesList
        };
      }
    });
  };

  /**
   * 指定したＩＤに該当する祭りデータを返すJQueryDeferrdを返します。
   *
   * @param fesId
   */
  Event.findOne = function (fesId) {
    return this.dataStore.findOne(fesId);
  }

  nm.Event = Event;
})(window.cfc = window.cfc || {});
