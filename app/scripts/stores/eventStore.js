(function (nm) {

  /**
   * 祭りイベントデータストア
   *
   * @constructor
   */
  var EventStore = function () {

  };

  EventStore.prototype = {
    /** アクセス先URL */
    url: "data/test-data2.json",

    /** 祭りデータキャッシュ */
    dataStore: null,

    /**
     * 全データを返すJQueryDeferrdを返します。
     *
     * @return JQueryDeferred
     */
    findAll: function () {

      if(this.dataStore){
        var d = new $.Deferred;
        d.resolve(this.dataStore);
        return d.promise();
      } else {
        var self = this;
        return $.getJSON(this.url).then(function(data){
          var list = [];
          for (var i in data) {

            // 日付をDate型に変換
            data[i].date = _.map(data[i].date, function(eventDate){
              eventDate.start = new Date(eventDate.start);
              eventDate.end = new Date(eventDate.end);
              return eventDate;
            });

            list.push(new cfc.Event(data[i]));
          }
          self.dataStore = list;
          return list;
        });
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
      }
      var sepchar = (url.indexOf('?') > -1) ? '&' : '?';
      script.src = url + sepchar + 'callback=' + callb;
      script.id = callb;
      document.getElementsByTagName('head')[0].appendChild(script);
    }
  };

  nm.EventStore = EventStore;
})(window.cfc = window.cfc || {});
