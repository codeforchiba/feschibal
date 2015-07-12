(function (nm) {
  'use strict';
  /**
   * 地域オブジェクト
   *
   * @constructor
   */
  var City = function (data) {
    for (var prop in data) {
      this[prop] = data[prop];
    }
  };

  City.prototype = {
    /**
     * 自身の区に紐づく全ての市町村を返します。
     *
     * @returns {Array} 市町村
     */
    getTowns: function () {
      var self = this;
      return City.dataStore.findAll().then(function(dataList){
        return _.filter(dataList, function(data){
          return data.addressCode.lastIndexOf("0000") < 0 && self.cityCode === data.cityCode;
        });
      });
    },

    /**
     * 区の場合はtureを返す
     */
    isWard: function(){
      return this.addressCode.lastIndexOf("0000") >= 0
    }
  };

  /**
   * データストア
   */
  City.dataStore = new cfc.CityStore();

  /**
   * 全データを返すJQueryDeferrdを返します。
   *
   * @return JQueryDeferred
   */
  City.findAll = function () {
    return this.dataStore.findAll();
  };

  /**
   * 指定したaddressCodeに該当する地域を返すJQueryDeferrdを返します。
   *
   * @param fesId
   */
  City.findOne = function (addressCode) {
    return this.dataStore.findOne(addressCode);
  }

  /**
   * 全ての区を返します。
   */
  City.findAllWards = function(){
    return this.dataStore.findAll().then(function(dataList){
      return _.filter(dataList, function(data){
        return data.isWard();
      });
    });
  }

  nm.City = City;
})(window.cfc = window.cfc || {});
