<app-header>
  <header class="matsuri-style">
    <div class="header-content">
      <h1>
        <a class="roll_fout" href="#"><img class="logo" src="images/common/logo.png" alt="千葉市お祭りデータセンター"></a>
        <div class="pull-right">
          <a href="https://codeforchiba.typeform.com/to/tpiHfF" class="btn regist-btn typeform-share link" target = "_blank" data-mode = "1"><img src="images/common/btn_icon.png" alt=""/> お祭りデータ登録</a>
        </div>
      </h1>
    </div>
  </header>

  <style scoped>
    header {
      background: #fff url(images/common/patrun_02.gif) left top repeat-x;
      border-bottom: 2px solid #e84518;
    }

    h1 {
      padding: 28px 0px 20px;
      position: relative;
    }

    .header-content {
      width: 1000px;
      margin: 0 auto;
    }

    .regist-btn{
      font-size:16px;
      background-color:#e84518;
      border:2px solid #f06741;
      color: #fff;
      line-height: 30px;
      padding-left: 16px;
      padding-right: 16px;
      margin-top: 5px;
    }
    .regist-btn img {
      vertical-align: middle;
    }
    .regist-btn:hover,
    .regist-btn:focus{
      background-color:#c52d03;
      border:2px solid #c52d03;
      color: #fff;
    }

    @media only screen and (max-width: 640px) {
      h1 {
        padding: 10px 0px 10px 10px;
      }

      h1 img.logo {
        width: 70%;
      }

      .header-content {
        width: 100%;
      }

      .regist-btn {
        display: none;
      }
    }
  </style>
</app-header>
