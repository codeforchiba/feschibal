<app-header>
  <div class="navbar navbar-fixed-top" role="navigation">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#" if={ path !== 'detail' }>Feschibal</a>
        <a class="navbar-brand" href="javascript:history.back();"  if={ path === 'detail' }><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span></a>
      </div>
    </div>
  </div>
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
    .navbar {
      background: rgba(255, 255, 255, .5);
    }
    .navbar a{
      color: #F4A838;
    }
    .navbar a:hover, .navbar a:focus{
      color: #E39727;
    }
  </style>
</app-header>
