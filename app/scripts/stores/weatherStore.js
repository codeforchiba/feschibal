(function (nm) {
  'use strict';
  /**
   * 天気データストア
   *
   * @constructor
   */
  var WeatherStore = function () {

  };

  WeatherStore.prototype = {
    /** アクセス先URL */
    url: '@@url.weather_cache',

    storeData: function (data) {
      if (_.isEmpty(data)){
        return;
      }
      var reportDateTime = new Date(data.reportDateTime);
      for (var i = 0; i < 7; i++) {
        var weather = new cfc.Weather();
        weather.reportDateTime = reportDateTime;
        weather.forecastDateTime = new Date(data.area[0].forecastDateTime[i]);
        weather.weather = data.area[0].weather[i];
        weather.weatherCode = data.area[0].weatherCode[i];
        weather.precipitation = data.area[0].precipitation[i];
        weather.temperatureMax = data.area[0].temperatureMax[i];
        weather.temperatureMin = data.area[0].temperatureMin[i];

        var key = this._getDateKey(weather.forecastDateTime);
        this.dataStore[key] = weather;
      }
    },

    /**
     * 日付オブジェクトからキーを生成
     * @param date
     * @returns {*}
     * @private
     */
    _getDateKey: function (date) {
      return moment(date).format('YYYYMMDD');
    },

    /**
     * 指定日付の天気予報を返します。
     * @param date
     */
    findByDate: function (date) {
      var key = this._getDateKey(date);
      return this.findOne(key);
    }
  };

  _.defaults(WeatherStore.prototype, cfc.StoreBase.prototype)

  nm.WeatherStore = WeatherStore;
})(window.cfc = window.cfc || {});
