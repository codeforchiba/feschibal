<announcement>
  <div class="main">
    <div class="main-img">
      <h2 class="matsuri-style">お知らせ</h2>
      <img src="images/home/main.jpg" alt="お知らせ" />
    </div>
  </div>

  <article class="content">
    <announcement-list announcementlist={announcements} ></announcement-list>
  </article>

  <style scorped>
  .main .main-img h2 {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    -webkit-transform: translate(-50%, -50%); /* Safari用 */
    transform: translate(-50%, -50%);
    font-size: 36px;
    color: #fff;
  }
  </style>
</announcement>