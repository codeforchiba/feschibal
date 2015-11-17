<app-footer>
  <footer>
    <ul class="clearfix matsuri-style">
      <li>
        <a href="javascript:void(0)" onclick="{showAbout}">このサービスについて</a>
      </li>
      <li>
        <a href="javascript:void(0)" onclick="{showCredit}">クレジット</a>
      </li>
      <li>
        <a href="https://codeforchiba.typeform.com/to/qzQYxn" class = "typeform-share link" target =  "_blank" data-mode = "1">問い合わせ</a>
      </li>
      <li>
        <a href="https://codeforchiba.typeform.com/to/tpiHfF" class = "typeform-share link" target = "_blank" data-mode = "1">お祭りデータの登録依頼</a>
      </li>
    </ul>
    <p>
      <a href="http://code4chiba.org/">
        <img src="images/common/codeforchiba.gif" alt="Code For Chiba">
      </a>
    </p>
  </footer>

  <google-analytics></google-analytics>
  <typeform></typeform>

  <script>
    showAbout(e) {
      riot.route("about");
    };

    showCredit(e) {
      riot.route("credit");
    }
  </script>

  <style scoped>
    footer {
      background: #fff url(images/common/footer-line.gif) left top repeat-x;
      padding-top: 30px;
    }

    ul {
      width: 600px;
      margin: 10px auto 30px;
    }

    li {
      float: left
    }

    li + li {
      margin-left: 30px;
    }

    p {
      text-align: center;
    }

    p img {
      width: 240px;
    }

    .copyright {
      background: #2c2c2c;
      padding: 10px 0;
      color: #fff;
      margin-bottom: 0;
    }

    .copyright a {
      color: #ddd;
    }

    @media only screen and (max-width: 640px) {
      footer {
        background: #fff url(images/common/footer-line.gif) left top repeat-x;
      }

      ul {
        width: auto;
      }

      li {
        float: none;
        text-align: center;
        line-height: 2.0;
      }

      li + li {
        margin-left: 0;
      }

      p {
        text-align: center;
      }

      p img {
        width: 50%;
      }

      p.copyright img {
        width: auto;
      }

      .copyright {
        background: #2c2c2c;
        padding: 20px 0;
        color: #fff;
      }
    }
  </style>
</app-footer>
