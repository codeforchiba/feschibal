(function (nm) {
  'use strict';

  /**
   * 天気オブジェクト
   *
   * @constructor
   */
  var Weather = function (data) {
    for (var prop in data) {
      this[prop] = data[prop];
    }
  };

  Weather.prototype = {
    /** 予報時刻 */
    reportDateTime: null,
    /** 予報日時 */
    forecastDateTime: null,
    /** 天気 */
    weather: null,
    /** 天気テロップコード */
    weatherCode: null,
    /** 降水確率 */
    precipitation: null,
    /** 最高気温 */
    temperatureMax: null,
    /** 最低気温 */
    temperatureMin: null
  };

  /**
   * データストア
   */
  Weather.dataStore = new cfc.WeatherStore();

  /**
   * 指定日付の天気予報を返します。
   *
   * @param fesId
   */
  Weather.findByDate = function (date) {
    return this.dataStore.findByDate(date);
  }

  nm.Weather = Weather;
})(window.cfc = window.cfc || {});
