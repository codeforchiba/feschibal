<credit>
  <article class="content">
    <section id="credit-list">
      <h1>クレジット</h1>
      <h2>企画</h2>
      <ul class="clearfix">
        <li>NIIOKA Shigetomo</li>
        <li>OGAWA Junichi</li>
        <li>OKAMOTO Naomi</li>
        <li>TAKAHASHI Fumiki</li>
        <li>ASANO Hiroyuki</li>
        <li>YAMAMOTO Munehiro</li>
        <li>FUKUTANI Shouko</li>
        <li>SHIMIZU Yasuo</li>
      </ul>
      <h2>エンジニア</h2>
      <ul class="clearfix">
        <li>MITSUI Yasuyuki</li>
        <li>TOZUKA Yoshihiro</li>
        <li>URAMOTO Kazunori</li>
        <li>TAKAGI Masanobu</li>
      </ul>
      <h2>デザイナー</h2>
      <ul class="clearfix">
        <li>TAKEMOTO Yasushi</li>
      </ul>
      <h2>アドバイザー</h2>
      <ul class="clearfix">
        <li>KANEOYA Yoshihiko</li>
        <li>MATSUSHIMA Ryuichi</li>
        <li>SAGARA Toshihiro</li>
        <li>MURAKAWA Akihisa</li>
      </ul>
    </section>
    <section id="credit-navi">
      <p>
        <a href="javascript:void(0)" onclick="{doHome}">
          トップへ戻る
        </a>
      </p>
    </section>
  </article>

  <script>
    doHome(e) {
      riot.route("#home");
    }
  </script>

  <style scoped>
    section {
      width: 600px;
      margin: 0 auto;
    }

    section + section {
      margin-top: 30px;
    }

    section h1 {
      text-align: center;
      font-size: 26px;
      margin-bottom: 26px;
    }

    section h2 {
      text-align: center;
      font-size: 22px;
    }

    section p {
      line-height: 2.0;
      margin-bottom: 12px;
      text-align: center;
    }

    section ul {
      width: 600px;
      margin: 16px auto;
    }

    section li {
      float: left;
      width: 300px;
      text-align: center;
      font-size: 14px;
      line-height: 2.0;
    }

    section li:hover {
      cursor: pointer;
      color: #F93;
    }

    #credit-navi p {
      text-align: center;
      padding-bottom: 40px;
    }

    @media only screen and (max-width: 640px) {
      section {
        width: auto;
      }

      section ul {
        width: auto;
      }

      section li {
        float: none;
        width: auto;
      }
    }
  </style>
</credit>
