<nav-header>
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
      <div class="navbar-header">
        <div class="navbar-icon-container">
          <a href="#" class="navbar-icon pull-right visible-xs" onclick={onClickNavBtn}><i class="fa fa-bars fa-lg white"></i></a>
          <a href="#" class="navbar-icon pull-right visible-xs" onclick={onClickSidebarToggleBtn}><i class="fa fa-list fa-lg white"></i></a>
        </div>
        <a class="navbar-brand" href="#">ちば自転車マップ</a>
      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">

          <li><a href="#" data-toggle="collapse" data-target=".navbar-collapse.in" onclick={onClickAboutBtn}><i class="fa fa-question-circle white"></i>&nbsp;&nbsp;情報</a></li>
          <li><a href="#" data-toggle="collapse" data-target=".navbar-collapse.in" onclick={onClickLegendBtn}><i class="fa fa-picture-o"></i>&nbsp;&nbsp;凡例</a></li>
          <li class="hidden-xs"><a href="#" data-toggle="collapse" data-target=".navbar-collapse.in" onclick={onClickListBtn}><i class="fa fa-list white"></i>&nbsp;&nbsp;POI List</a></li>
        </ul>
        <form class="navbar-form navbar-right" role="search">
          <div class="form-group has-feedback">
            <input id="searchbox" type="text" placeholder="Search" class="form-control">
            <span id="searchicon" class="fa fa-search form-control-feedback"></span>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script>
    /**
     * 情報ボタン押下時
     */
    onClickAboutBtn(e) {
      $("#aboutModal").modal("show");
      return false;
    }

    /**
     * 凡例ボタン押下時
     */
    onClickLegendBtn(e) {
      $("#legendModal").modal("show");
      return false;
    }

    /**
     * ナビゲーションボタン押下時
     */
    onClickNavBtn(e) {
      $(".navbar-collapse").collapse("toggle");
      return false;
    }

    /**
     * リストボタン押下時
     */
    onClickListBtn(e) {
      $('#sidebar').toggle();
      opts.mapctr.resize();
      return false;
    }

    /**
     * サイドバートグルボタン押下時
     */
    onClickSidebarToggleBtn(e) {
      $("#sidebar").toggle();
      opts.mapctr.resize();
      return false;
    }
  </script>
  <style>
    nav-header .navbar .navbar-brand {
      font-weight: bold;
      font-size: 25px;
      color: #FFFFFF;
    }
    nav-header .navbar-collapse.in {
      overflow-y: hidden;
    }
    nav-header .navbar-header .navbar-icon-container {
      margin-right: 15px;
    }
    nav-header .navbar-header .navbar-icon {
      line-height: 50px;
      height: 50px;
    }
    nav-header .navbar-header a.navbar-icon {
      margin-left: 25px;
    }

    nav-header .has-feedback .form-control-feedback {
      position: absolute;
      top: 0;
      right: 0;
      display: block;
      width: 34px;
      height: 34px;
      line-height: 34px;
      text-align: center;
    }

    @media (max-width: 992px) {
      nav-header .navbar .navbar-brand {
        font-size: 18px;
      }
    }

    /* Print Handling */
    @media print {
      nav-header .navbar {
        display: none !important;
      }
    }
  </style>
</nav-header>
