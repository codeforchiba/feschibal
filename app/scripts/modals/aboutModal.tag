<about-modal>
  <div class="modal fade" id="aboutModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">千葉市自転車走りやすさマップ</h4>
        </div>
        <div class="modal-body">
          <ul class="nav nav-tabs" id="aboutTabs">
            <li class="active"><a href="#about" data-toggle="tab"><i class="fa fa-question-circle"></i>&nbsp;このプロジェクトについて</a>
            </li>
            <li><a href="#disclaimer" data-toggle="tab"><i class="fa fa-exclamation-circle"></i>&nbsp;免責事項</a></li>
          </ul>
          <div class="tab-content" id="aboutTabsContent">
            <div class="tab-pane fade active in" id="about">
              <p>この地図は千葉市が作成している<a href="http://www.city.chiba.jp/kensetsu/doboku/bicycle/soukoukankyouseibi.html"
                                   target="_blank">千葉市走りやすさマップ</a>をオンラインに移植をしたものです。
                紙のデータを<a href="http://umap.openstreetmap.fr/ja/" target="_blank">uMap</a>を使ってオンライン上でデータ化をして、
                そのデータを元に<a href="https://github.com/bmcbride/bootleaf" target="_blank">BootLeaf</a>をベースにオンライン地図にしました。
                このオンライン地図は、オープン！千葉の活動及び
                <a href="http://opendataday.org/index_ja.html" target="_blank">International Open Data Day 2015</a>の活動にて生まれました。
                全てのデータ及びプログラムは<a href="https://github.com/smellman/chiba_bicyclemap" target="_blank">Github</a>にて公開されています。
              </p>

              <div class="panel panel-primary">
                <div class="panel-heading">利用データ</div>
                <ul class="list-group">
                  <li class="list-group-item">背景地図は<a href="http://www.gsi.go.jp/" target="_blank">国土地理院</a>の<a
                    href="http://portal.cyberjapan.jp/help/development/ichiran.html" target="_blank">地理院タイル</a>を利用しています。
                  </li>
                  <li class="list-group-item">バス停のデータは<a href="http://nlftp.mlit.go.jp/ksj/" target="_blank">国土数値情報</a>を利用しています。
                  </li>
                  <li class="list-group-item">バス停のアイコンには<a href="https://www.mapbox.com/maki/" target="_blank">Maki</a>を利用しています。
                  </li>
                </ul>
              </div>
            </div>
            <div id="disclaimer" class="tab-pane fade text-danger">
              <p>自転車を走りながらの閲覧はやめましょう！</p>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <style>
    #aboutTabsContent {
      padding-top: 10px;
    }
  </style>
</about-modal>
