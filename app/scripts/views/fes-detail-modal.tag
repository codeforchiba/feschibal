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
              2015年3月6日（金曜日）11時00分から2015年3月6日（金曜日）11時30分
            </div>
          </div>

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">祭り内容</h3>
            </div>
            <div class="panel-body">
              <dl class="dl-horizontal">
                <dt>目玉</dt>
                <dd>2千人規模で踊る親子三代千葉おどり</dd>
              </dl>
              <img src="../../images/chiba-odori.jpg" alt=""/>
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
                <td><i class="fa fa-check"></i></td>
                <td></td>
                <td><i class="fa fa-check"></i></td>
                <td></td>
                <td><i class="fa fa-check"></i></td>
                <td><i class="fa fa-check"></i></td>
                <td class="other">スポーツイベント、フリーマーケット</td>
              </tr>
              </tbody>
            </table>
            <dl class="dl-horizontal">
              <dt>祭り公式サイト</dt>
              <dd><a href="http://www.bikai.org/matsuri.html">http://www.bikai.org/matsuri.html</a></dd>
            </dl>
          </div>

          <div class="panel panel-section">
            <div class="panel-heading">
              <h3 class="panel-title">場所</h3>
            </div>
            <div class="panel-body">
              <dl class="dl-horizontal">
                <dt>会場</dt>
                <dd>中央公園</dd>
                <dt>住所</dt>
                <dd>中央区中央1-12-1</dd>
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
                <dd>千葉市を美しくする会</dd>
                <dt>共催</dt>
                <dd>千葉市市民自治推進課</dd>
                <dt>担当者</dt>
                <dd>千葉 祭</dd>
                <dt>電話番号</dt>
                <dd>043-999-9999</dd>
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

      var map = L.map($mapEl[0]).setView([opts.fes.coordinates[1],opts.fes.coordinates[0]], 14);
      L.marker([opts.fes.coordinates[1],opts.fes.coordinates[0]]).addTo(map);
      L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
        maxZoom: 18,
        attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
        opacity: 0.8
      }).addTo(map);
    },50);
  </script>

  <style>
    fes-detail-modal .panel.panel-section {
      -webkit-box-shadow: none;
      box-shadow: none;
    }

    fes-detail-modal .panel.panel-section .panel-heading {
      border-bottom: 3px solid #e5e5e5;
    }

    fes-detail-modal .dl-horizontal dt {
      width: 60px;
    }

    fes-detail-modal .dl-horizontal dd {
      margin-left: 80px;
    }

    fes-detail-modal .table.table-bordered th,
    fes-detail-modal .table.table-bordered td {
      text-align: center;
    }

    fes-detail-modal .table.table-bordered td.other {
      text-align: left;
    }

    fes-detail-modal #detail-map {
      height: 300px;
    }
  </style>
</fes-detail-modal>
