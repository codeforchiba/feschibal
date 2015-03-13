<loading>
  <div class="loading-indicator">
    <div class="progress progress-striped active">
      <div class="progress-bar progress-bar-info progress-bar-full"></div>
    </div>
  </div>
  <script>
    $(document).one("ajaxStop", function () {
      $("loading").hide();
    });
  </script>
  <style>
    loading {
      position: absolute;
      width: 220px;
      height: 19px;
      top: 50%;
      left: 50%;
      margin: -10px 0 0 -110px;
      z-index: 20001;
    }

    loading .progress-bar-full {
      width: 100%;
    }
  </style>
</loading>
