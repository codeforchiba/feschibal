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
    url: '@@url',

    /** 祭りデータキャッシュ */
    dataStore: null,

    /**
     * 全祭りデータを返すJQueryDeferrdを返します。
     *
     * @return JQueryDeferred
     */
    findAll: function () {

      if (this.dataStore) {
        var d = new $.Deferred();
        d.resolve(_.values(this.dataStore));
        return d.promise();
      } else {
        var self = this;
        return this._getJSON(this.url).then(function (dataList) {
          self.dataStore = {};
          var list = _.map(dataList, function (data) {
            // 日付をDate型に変換
            data.date = _.map(data.date, function (eventDate) {
              eventDate.start = new Date(eventDate.start);
              eventDate.end = new Date(eventDate.end);
              return eventDate;
            });
            self.dataStore[data.id] = new cfc.Event(data);
            return self.dataStore[data.id];
          });
          return list;
        });
      }
    },

    /**
     * 指定したＩＤに該当する祭りデータを返すJQueryDeferrdを返します。
     *
     * @param id
     * @return JQueryDeferred
     */
    findOne: function (id) {
      var self = this;
      if (this.dataStore) {
        var d = new $.Deferred();
        var fes = self.dataStore[id];
        if (fes) {
          d.resolve(fes);
        } else {
          d.reject();
        }
        return d.promise();
      } else {
        return this.findAll().then(function(){
          var d = new $.Deferred();
          var fes = self.dataStore[id];
          if (fes) {
            d.resolve(fes);
          } else {
            d.reject();
          }
          return d.promise();
        });
      }
    },

    /**
     * 環境変数のprotocol状況に応じたリクエスト方法でデータを取得します。
     *
     * @param url {String} url
     * @returns {JQueryDeferred}
     * @private
     */
    _getJSON: function (url) {
      if ('@@protocol' === 'JSONP') {
        var d = new $.Deferred();
        this._jsonp(url, function (data) {
          d.resolve(data);
        });
        return d.promise();
      } else {
        return $.getJSON(url);
      }
    },

    /**
     * リクエストを送信します。（クロスドメイン対応）
     * @param url
     * @param cb
     * @private
     */
    _jsonp: function (url, cb) {
      var script = document.createElement('script');
      script.async = true;
      var callb = 'exec' + Math.floor((Math.random() * 65535) + 1);
      window[callb] = function (data) {
        var scr = document.getElementById(callb);
        scr.parentNode.removeChild(scr);
        cb(data);
        window[callb] = null;
        delete window[callb];
      };
      var sepchar = (url.indexOf('?') > -1) ? '&' : '?';
      script.src = url + sepchar + 'callback=' + callb;
      script.id = callb;
      document.getElementsByTagName('head')[0].appendChild(script);
    }
  };

  nm.EventStore = EventStore;
})(window.cfc = window.cfc || {});
