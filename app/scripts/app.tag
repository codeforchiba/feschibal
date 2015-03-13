<app>
  <nav-header mapctr={mapController}></nav-header>

  <div id="container">
    <sidebar id="sidebar" mapctr={mapController}></sidebar>
    <bicycle-map mapctr={mapController}></bicycle-map>
  </div>
  <loading></loading>

  <about-modal></about-modal>
  <legend-modal></legend-modal>
  <feature-modal></feature-modal>

  <script>
    /**
     * マップに対する操作
     */
    this.mapController = riot.observable();
    this.mapController.resize = function(){
      this.trigger('resize')
    }
  </script>
</app>
