<fes-list>
  <ul class="festival-list">
    <li class="festival-list-date" each={ fes, i in opts.feslist } onclick={parent.onSelectFes}>
      <dl>
        <dt>
          <p class="day">
            <span class="bgcolor" each={ date in fes.date } >
              {moment(date.start).format('MM/DD')}
              <span class="small">{moment(date.start).format('dd')}</span>
            </span>
          </p>

          <p class="title">{fes.name}</p>
        </dt>
        <dd>
          <a href="javascript:void(0)">
            <img class="roll_fout" src="images/common/pic01.jpg">
          </a>
        </dd>
      </dl>
    </li>
  </ul>

  <script>
    // 祭り選択時
    onSelectFes(e){
      riot.route("detail/" + e.item.fes.id);
    }
  </script>

  <style scoped>
    .festival-list {
      padding: 0 20px;
    }

    .festival-list-date {
      width: 300px;
      float: left;
      margin-right: 30px;
      margin-bottom: 30px;
    }

    .festival-list-date .day {
      font-size: 26px;
      font-family: 'Merriweather', serif;
      font-weight: 400;
      color: #fff;
      margin-bottom: 3px;
      letter-spacing: 0.1em;
    }

    .festival-list-date .day .small {
      font-size: 18px;
    }

    .festival-list-date .day .bgcolor {
      background: #dc79a2;
      padding: 6px;
      margin-right: 5px;
    }

    .festival-list-date .title {
      background: #4c4c4c;
      padding: 8px;
      font-size: 26px;
      font-weight: bold;
      color: #fff;
      margin-bottom: 0;
    }

    .festival-list-date:nth-child(3n) {
      margin-right: 0px;
    }

    .festival-list:after {
      content: ".";
      display: block;
      height: 0;
      font-size: 0;
      clear: both;
      visibility: hidden;
    }

    @media only screen and (max-width: 640px) {
      .festival-list {
        padding: 0;
      }

      .festival-list-date {
        width: 100%;
        float: none;
        position: relative;
        margin-right: 0;
        margin-bottom: 1px;
      }

      .festival-list-date dt {
        position: absolute;
        top: 20px;
        left: 10px;
      }

      .festival-list-date dt .day {
        font-size: 18px;
        font-family: 'Merriweather', serif;
        font-weight: 400;
        color: #fff;
        margin-bottom: 5px;
        letter-spacing: 0.1em;
      }

      .festival-list-date dt .day .small {
        font-size: 14px;
      }

      .festival-list-date dt .day .bgcolor {
        background: #dc79a2;
        padding: 8px;
      }

      .festival-list-date dt .title {
        background: #4c4c4c;
        padding: 8px;
        font-size: 18px;
        font-weight: bold;
        color: #fff;
        margin-bottom: 0;
      }

      .festival-list-date dd {
        height: 110px;
        overflow: hidden;
        background: #383838;
      }

      .festival-list-date dd img {
        width: 100%;
      }

      .festival-list-date:nth-child(3n) {
        margin-right: 6%;
      }

      .festival-list-date:nth-child(2n) {
        margin-right: 0;
      }
    }
  </style>
</fes-list>
