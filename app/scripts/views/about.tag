<about>
  <article class="content">
    <section id="about-introduction">
      <img src="./images/facebook.jpg">
      <p>本サービスは、千葉市で長い間親しまれているお祭りについて、お知らせする無料サービスです。</p>
      <p>いつ、どこで、どんなお祭りが行われるのか、ひと目でわかるように情報をまとめました。</p>
      <p>ご家族で、お友だち同士で、もちろんおひとりでも大丈夫。</p>
      <p>千葉市のそこかしこで賑わうお祭りに繰り出して、みんなで千葉市を元気にしましょう。</p>
    </section>
    <section id="about-source">
      <h1>お祭り情報について</h1>
      <p>各地域のお祭り情報は、千葉市が公開するオープンデータを使用しています。</p>
      <p>今後はこちらに独自の情報を追加してデータベースを拡充していく予定です。</p>
    </section>
    <section id="about-navi">
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

    section img {
      width: 600px;
      margin-bottom: 30px;
    }

    section h1 {
      text-align: center;
      margin-bottom: 26px;
    }

    section p {
      line-height: 2.0;
      margin-bottom: 12px;
      text-align: center;
    }

    #about-introduction h1 {
      font-size: 26px;
    }

    #about-source h1 {
      font-size: 22px;
    }

    #about-navi p {
      text-align: center;
      padding-bottom: 40px;
    }

    @media only screen and (max-width: 640px) {
      section {
        width: auto;
      }

      section img {
        width: 100%;
      }

      section p {
        line-height: 2.0;
        margin: 0 10px 12px;
        text-align: left;
      }
    }
  </style>

</about>
