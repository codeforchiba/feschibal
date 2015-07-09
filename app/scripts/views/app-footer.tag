<app-footer>
  <footer>
    <p><img src="images/common/codeforchiba.gif" alt="Code For Chiba"></p>
    <p class="copyright">Copyright &copy; Code for Chiba All rights reserved.</p>
  </footer>

  <style scoped>
    footer {
      background: #fff url(images/common/footer-line.gif) left top repeat-x;
      padding-top: 30px;
    }

    p {
      text-align: center;
    }

    .copyright {
      background: #2c2c2c;
      padding: 10px 0;
      color: #fff;
      margin-bottom: 0;
    }

    @media only screen and (max-width: 640px) {
      footer {
        background: #fff url(images/common/footer-line.gif) left top repeat-x;
      }

      p {
        text-align: center;
      }

      p img {
        width: 50%;
      }

      .copyright {
        background: #2c2c2c;
        padding: 20px 0;
        color: #fff;
      }
    }
  </style>
</app-footer>
