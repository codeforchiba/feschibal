<fes-list>
  <ul class="festival-list">
    <wrap each={ fes, i in opts.feslist }>
      <div class="clearfix" if={ i%3 === 0}></div>
      <li class="festival-list-date" onclick={parent.onSelectFes}>
        <dl>
          <dt>
          <p class="day" if={fes.getUniquePeriods().length <= 2}>
            <span class="bgcolor" each={ period in fes.getUniquePeriods() } >
              {moment(period.start).format('MM/DD')}
              <span class="small matsuri-style">{moment(period.start).format('dd')}</span>
            </span>
          </p>
          <p class="day" if={fes.getUniquePeriods().length > 2}>
            <span class="bgcolor" >
              {moment(fes.getStartDate()).format('MM/DD')}
              <span class="small matsuri-style">{moment(fes.getStartDate()).format('dd')}</span>
              -
              {moment(fes.getUniquePeriods()[fes.getUniquePeriods().length - 1].start).format('MM/DD')}
              <span class="small matsuri-style">{moment(fes.getUniquePeriods()[fes.getUniquePeriods().length - 1].start).format('dd')}</span>
            </span>
          </p>
          <p class="title matsuri-style">{fes.name}</p>
          </dt>
          <dd>
            <a href="javascript:void(0)">
              <img class="roll_fout" src="images/festival/{fes.id}/header.jpg" onerror={onErrorImgLoad}>
            </a>
          </dd>
        </dl>
      </li>
    </wrap>
  </ul>

  <script>
    // 祭り選択時
    onSelectFes(e){
      riot.route("detail/" + e.item.fes.id);
    }

    this.on('updated', function() {
      Ts.reload();
    });

    /**
     * 画像h表示に失敗した場合はデフォルト画像を表示
     */
    onErrorImgLoad(evt) {
      $(evt.target).attr({
        src: 'images/common/pic01.jpg'
      });
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

    wrap:nth-child(3n) .festival-list-date {
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

    .festival-list-date dd {
      width: 300px;
      height: 422px;
      overflow: hidden;
      display: block;
    }

    .festival-list-date dd img {
      height: 422px;
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
        width: 100%;
        height: 110px;
      }

      .festival-list-date dd img {
        width: 100%;
        height: auto;
      }

      wrap:nth-child(3n) .festival-list-date {
        margin-right: 6%;
      }

      wrap:nth-child(2n) .festival-list-date {
        margin-right: 0;
      }
    }
  </style>
</fes-list>
