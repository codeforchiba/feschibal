<announcement>
  <div class="main">
    <div class="main-img">
      <h2 class="matsuri-style">お知らせ</h2>
      <img src="images/home/main.jpg" alt="お知らせ" />
    </div>
  </div>
  
  <article class="content">
    <announcement-list show={ path==='list'} request={request} ></announcement-list>
    <!-- ページネーション -->
    <div class="pagenation">
      <ul>
        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>
        <li><a href="#">6</a></li>
        <li><a href="#">7</a></li>
        <li><a href="#">8</a></li>
        <li><a href="#">9</a></li>
        <li><a href="#">10</a></li>
      </ul>
    </div>
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
  .pagenation > ul{
    list-style-type: none;
    padding-left: 0;
    display: flex;
    justify-content: center;
  }

  .pagenation > ul > li{
    width: 50px;
    height: 50px;
    padding: 10px;
    margin: 10px;
    text-align: center;
    border: solid 1px #999;
    border-radius: 5px;
  }

  .pagenation > ul > li > a{
    line-height: 32px;
  }
  </style>
</announcement>