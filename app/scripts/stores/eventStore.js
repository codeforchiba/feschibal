(function (nm) {

  /**
   * 祭りイベントデータストア
   *
   * @constructor
   */
  var EventStore = function () {

  };

  EventStore.prototype = {

    /**
     * 全データを返します。
     */
    findAll: function (cb) {
      var self = this;
      this._jsonp("http://linkdata.org/api/1/rdf1s3024i/matsuri_list_v2_rdf.json", function (data) {
        var list = [];
        for (var i in data) {
          var fes = new feschibal.Event();
          // id
          fes.id = data[i]['http://www.w3.org/2000/01/rdf-schema#label'][0].value;

          // 公開可否(名前)
          fes.isExposeName = self._booleanValue(data[i], '公開可否(名前)');
          // 名前
          fes.name = self._strValue(data[i], '名前');

          // 公開可否(日時)
          fes.isExposeDate = self._booleanValue(data[i], '公開可否(日時)');
          // 開始日時
          fes.startDate = new Date(self._strValue(data[i], '開始日') + ' ' + self._strValue(data[i], '開始時刻'));
          // 終了日時
          fes.endDate = new Date(self._strValue(data[i], '終了日') + ' ' + self._strValue(data[i], '終了時刻'));

          // 公開可否(会場)
          fes.isExposePlace = self._booleanValue(data[i], '公開可否(会場)');
          // 会場名
          fes.place = self._strValue(data[i], '会場名');
          // 住所
          fes.address = self._strValue(data[i], '住所');
          // TODO:座標 住所からひっぱってくる

          // 公開可否(祭り内容)
          fes.isExposeContents = self._booleanValue(data[i], '公開可否(祭り内容)');
          // 祭り内容
          var contents = self._strValue(data[i], '祭り内容').split(',');
          // 踊り
          fes.hasDancing = contents.indexOf('踊り') >= 0;
          // 歌唱
          fes.hasSinging = contents.indexOf('歌唱') >= 0;
          // 太鼓
          fes.hasDrum = contents.indexOf('太鼓') >= 0;
          // 演奏
          fes.hasMusicalPerformance = contents.indexOf('演奏') >= 0;
          // 屋台
          fes.hasFoodStall = contents.indexOf('屋台') >= 0;
          // 花火
          fes.hasFireworks = contents.indexOf('花火') >= 0;
          // その他　TODO:取得

          // TODO:祭り画像

          // 公開可否(祭りの目玉)
          fes.isExposeSpecialProgram = self._booleanValue(data[i], '公開可否(祭りの目玉)');
          // 祭りの目玉
          fes.specialProgram = self._strValue(data[i], '祭りの目玉');

          // 公開可否(一般参加)
          fes.isExposeParticipation = self._booleanValue(data[i], '公開可否(一般参加)');
          // 一般参加可否
          fes.canParticipate = self._booleanValue(data[i], '一般参加可否');

          // ウェブサイト
          fes.officialSite = self._strValue(data[i], 'ウェブサイト');

          // 公開可否(主催団体)
          fes.isExposeSponsor = self._booleanValue(data[i], '公開可否(主催団体)');
          // 主催団体
          fes.sponsorGroup = self._strValue(data[i], '主催団体');

          // 公開可否(問い合わせ先・名前)
          fes.isExposeContactGroup = self._booleanValue(data[i], '公開可否(問い合わせ先・名前)');
          // 問い合わせ先・名前
          fes.contactGroup = self._strValue(data[i], '問い合わせ先・名前');

          // 公開可否(問い合わせ先・担当者)
          fes.isExposeContactPerson = self._booleanValue(data[i], '公開可否(問い合わせ先・担当者)');
          // 問い合わせ先・担当者
          fes.contactPerson = self._strValue(data[i], '問い合わせ先・担当者');

          // 公開可否(問い合わせ先・電話番号)
          fes.isExposeContactTel = self._booleanValue(data[i], '公開可否(問い合わせ先・電話番号)');
          // 問い合わせ先・電話番号
          fes.contactTel = self._strValue(data[i], '問い合わせ先・電話番号');

          // 公開可否(問い合わせ先・メールアドレス)
          fes.isExposeContactMail = self._booleanValue(data[i], '公開可否(問い合わせ先・メールアドレス)');
          // 問い合わせ先・メールアドレス
          fes.contactMail = self._strValue(data[i], '問い合わせ先・メールアドレス');

          list.push(fes);
        }
        cb && cb(list);
      });
    },

    /**
     * 指定した文字列の文字列値を返します。
     *
     * @param data
     * @param str
     * @returns {string|Number|value|*}
     * @private
     */
    _strValue: function (data, str) {
      var valueObj = data[this._jsonkey(str)];
      if (valueObj) {
        return valueObj[0].value;
      } else {
        return '';
      }
    },

    /**
     * 指定した文字列のBoolean値を返します。
     *
     * @param data
     * @param str
     * @returns {boolean}
     * @private
     */
    _booleanValue: function (data, str) {
      return this._strValue(data, str) === '1';
    },

    /**
     * jsonのキーを生成してかえします。
     * @param str
     * @returns {string}
     * @private
     */
    _jsonkey: function (str) {
      return "http://linkdata.org/property/rdf1s3024i#" + encodeURIComponent(str).replace('(', '%28').replace(')', '%29');
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
})(window.feschibal = window.feschibal || {});
