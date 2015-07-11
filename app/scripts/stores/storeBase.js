(function (nm) {
  'use strict';
  /**
   * データストア
   *
   * @constructor
   */
  var StoreBase = function () {
  };

  StoreBase.prototype = {

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
        return this.getJSON(this.url).then(function (dataList) {
          self.dataStore = {};
          self.storeData(dataList);
          return _.values(self.dataStore);
        });
      }
    },

    storeData: function(dataList){

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
    getJSON: function (url) {
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

  nm.StoreBase = StoreBase;
})(window.cfc = window.cfc || {});
