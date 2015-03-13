<sidebar>
  <div class="sidebar-wrapper">
    <div class="panel panel-default" id="features">
      <div class="panel-heading">
        <h3 class="panel-title">Points of Interest
          <button type="button" class="btn btn-xs btn-default pull-right" onclick={onClickSidebarHideBtn}><i class="fa fa-chevron-left"></i></button></h3>
      </div>
      <div class="panel-body">
        <div class="row">
          <div class="col-xs-8 col-md-8">
            <input type="text" class="form-control search" placeholder="Filter" />
          </div>
          <div class="col-xs-4 col-md-4">
            <button type="button" class="btn btn-primary pull-right sort" data-sort="feature-name" id="sort-btn"><i class="fa fa-sort"></i>&nbsp;&nbsp;Sort</button>
          </div>
        </div>
      </div>
      <div class="sidebar-table">
        <table class="table table-hover" id="feature-list">
          <thead class="hidden">
          <tr>
            <th>Icon</th>
          <tr>
          <tr>
            <th>Name</th>
          <tr>
          <tr>
            <th>Chevron</th>
          <tr>
          </thead>
          <tbody class="list"></tbody>
        </table>
      </div>
    </div>
  </div>

  <script>
    /**
     * 横ナビ隠すボタン押下時
     */
    onClickSidebarHideBtn(e) {
      $('#sidebar').hide();
      opts.mapctr.resize();
    }
  </script>

  <style>
    sidebar {
      width: 250px;
      height: 100%;
      max-width: 100%;
      float: left;
      transition: all 0.25s ease-out;
    }
    sidebar #features {
      margin: 0px;
      border: none;
      border-radius: 0px;
      -webkit-box-shadow: none;
      box-shadow: none;
    }
    sidebar .sidebar-wrapper {
      width: 100%;
      height: 100%;
      position: relative;
    }
    sidebar .sidebar-table {
      position: absolute;
      width: 100%;
      top: 103px;
      bottom: 0px;
      overflow: auto;
    }

    @media (max-width: 767px){
      sidebar {
        display: none;
      }
    }
  </style>
</sidebar>
