(function (nm) {
  'use strict';
  /**
   * 地域データストア
   *
   * @constructor
   */
  var CityStore = function () {

  };

  CityStore.prototype = {
    /** アクセス先URL */
    url: '@@url.city',

    storeData: function(dataList){
      _.each(dataList, function (data) {
        this.dataStore[data.addressCode] = new cfc.City(data);
      }, this);
    }
  };

  _.defaults(CityStore.prototype,  cfc.StoreBase.prototype)

  nm.CityStore = CityStore;
})(window.cfc = window.cfc || {});
