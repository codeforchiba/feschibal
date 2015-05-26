<fes-detail-modal>
  <div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title text-primary">{opts.fes.name}</h4>
        </div>
        <div class="modal-body">

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">期間</h3>
            </div>
            <div class="panel-body">
              <div each={ date, i in opts.fes.date }>
                {moment(date.start).format('YYYY年M月D日（dddd）H時m分')}　から　{moment(date.end).format('YYYY年M月D日（dddd）H時m分')}
              </div>
            </div>
          </div>

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">祭り内容</h3>
            </div>
            <div class="panel-body">
              <dl class="dl-horizontal">
                <dt>目玉</dt>
                <dd>
                  <span each={ program, i in opts.fes.features.specialProgram }>
                    <span if={ i > 0 }>、 </span>{program}
                  </span>
                </dd>
              </dl>
              <img src="/images/chiba-odori.jpg" alt=""/>
            </div>
            <table class="table table-bordered">
              <thred>
                <tr>
                  <th>踊り</th>
                  <th>歌唱</th>
                  <th>太鼓</th>
                  <th>演奏</th>
                  <th>出店・屋台</th>
                  <th>花火</th>
                  <th>その他</th>
                </tr>
              </thred>
              <tbody>
              <tr>
                <td><i class="fa fa-check" if={opts.fes.features.dancing}></i></td>
                <td><i class="fa fa-check" if={opts.fes.features.singing}></i></td>
                <td><i class="fa fa-check" if={opts.fes.features.drum}></i></td>
                <td><i class="fa fa-check" if={opts.fes.features.musicalPerformance}></i></td>
                <td><i class="fa fa-check" if={opts.fes.features.foodTruck}></i></td>
                <td><i class="fa fa-check" if={opts.fes.features.fireworks}></i></td>
                <td class="other">
                  <span each={ program, i in opts.fes.features.others }>
                    <span if={ i > 0 }>、 </span>{program}
                  </span>
                </td>
              </tr>
              </tbody>
            </table>
            <dl class="dl-horizontal" if={opts.fes.url}>
              <dt>祭り公式サイト</dt>
              <dd><a href="{opts.fes.url}">{opts.fes.url}</a></dd>
            </dl>
          </div>

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">場所</h3>
            </div>
            <div class="panel-body">
              <dl class="dl-horizontal">
                <dt>会場</dt>
                <dd>{opts.fes.location.name}</dd>
                <dt>住所</dt>
                <dd>{opts.fes.location.address}</dd>
              </dl>
              <div id="detail-map"></div>
            </div>
          </div>

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">主催、共催、後援</h3>
            </div>
            <div class="panel-body">
              <dl class="dl-horizontal">
                <dt>主催</dt>
                <dd>
                  <span each={ organizer, i in opts.fes.organizer }>
                    <span if={ i > 0 }>、 </span>{organizer}
                  </span>
                </dd>
              </dl>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <script>
    var $mapEl = $(this['detail-map']);
    var checkVisible = setInterval(function(){
      if(!$mapEl.length || !$mapEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      var map = L.map($mapEl[0]).setView([opts.fes.location.lat, opts.fes.location.long], 14);
      L.marker([opts.fes.location.lat, opts.fes.location.long]).addTo(map);
      L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
        maxZoom: 18,
        attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
        opacity: 0.8
      }).addTo(map);
    },50);
  </script>

  <style scoped>
    .panel.panel-section {
      -webkit-box-shadow: none;
      box-shadow: none;
    }

    .panel.panel-section .panel-heading {
      border-bottom: 3px solid #e5e5e5;
    }

    .dl-horizontal dt {
      width: 60px;
    }

    .dl-horizontal dd {
      margin-left: 80px;
    }

    .table.table-bordered th,
    .table.table-bordered td {
      text-align: center;
    }

    .table.table-bordered td.other {
      text-align: left;
    }

    #detail-map {
      height: 300px;
    }
  </style>
</fes-detail-modal>
