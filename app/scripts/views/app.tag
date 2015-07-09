<app>
  <app-header></app-header>
  <home show={ path === 'home' }></home>
  <search show={ path === 'search' }></search>
  <fes-detail show={ path === 'detail' }></fes-detail>
  <app-footer></app-footer>

  <script>
    var self  = this;

    /** 表示ページパス */
    this.path = null;
    /** 選択された祭り */
    this.fes = null;

    /**
     * 画面切替時
     */
    riot.route.on('routeChange', function(path){
      self.path = path;
      self.update();
    });

  </script>

  <style scoped>

  </style>
</app>
