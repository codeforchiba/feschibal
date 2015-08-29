<credit>
  <article class="content">
    <section id="credit-list">
      <h1>クレジット</h1>
      <h2>企画</h2>
      <ul class="clearfix">
        <li>
          <member uuid="6735387e-450f-44ee-9ced-91ae797c0c97"></member>
        </li>
        <li>
          <member uuid="029a587a-a2bd-412a-ac02-35f49bb70995"></member>
        </li>
        <li>
          <member uuid="cfb8d07e-464b-43f0-810f-a3ccba08b3e6"></member>
        </li>
      </ul>
      <ul class="clearfix">
        <li>OGAWA Junichi</li>
        <li>OKAMOTO Naomi</li>
        <li>TAKAHASHI Fumiki</li>
        <li>YAMAMOTO Munehiro</li>
        <li>SHIMIZU Yasuo</li>
      </ul>
      <h2>エンジニア</h2>
      <ul class="clearfix">
        <li>
          <member uuid="ddb396bd-dc7b-4d20-ae7a-df2e2470c377"></member>
        </li>
        <li>
          <member uuid="957c87fc-b968-463e-99d1-a6f18a065c83"></member>
        </li>
        <li>
          <member uuid="5ed8ae73-f571-4bd4-8707-7e76456ecc65"></member>
        </li>
        <li>
          <member uuid="8c633cf3-fb3c-4710-86cb-6bce874d98c0"></member>
        </li>
      </ul>
      <h2>デザイナー</h2>
      <ul class="clearfix">
        <li>
          <member uuid="aebfcc03-ead7-445c-9e41-f78ae07fd2ce"></member>
      </ul>
      <h2>アドバイザー</h2>
      <ul class="clearfix">
        <li>
          <member uuid="b9010dbd-ef0b-484a-a64b-6c7ee0baf73f"></member>
        </li>
        <li>
          <member uuid="0dc3fb03-c899-422b-ac79-23c650bda893"></member>
        </li>
      </ul>
      <ul class="clearfix">
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

    section li:nth-child(2n) iframe {
      margin-left: 10px;
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

      section li:nth-child(2n) iframe {
        margin-left: 0;
      }
    }
  </style>
</credit>
