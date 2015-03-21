<app>
  <app-header></app-header>
  <div class="content">
    <home if={ path === 'home' } listener={listener}></home>
    <search if={ path === 'search' } listener={listener}></search>
    <fes-detail-modal fes={fes}></fes-detail-modal>
  </div>
  <app-footer></app-footer>

  <script>
    var self  = this;

    /** 表示ページパス */
    this.path = null;
    /** 選択された祭り */
    this.fes = null;

    /**
     * 祭り選択時
     * @type {{onSelectFes: Function}}
     */
    this.listener = {
      onSelectFes : function(fes){
        self.fes = fes;
        self.update();
        $("fes-detail-modal > div").modal("show");
      }
    }

    /**
     * 画面切替時
     */
    riot.route.on('routeChange', function(path){
      console.log('routeChange path='+path);
      self.path = path;
      self.update();
    });

  </script>

  <style>
    app .content {
      padding: 15px;
    }
  </style>
</app>
