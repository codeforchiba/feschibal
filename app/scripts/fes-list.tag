<fes-list>
  <div class="row">
    <div class="col-lg-3">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>検索結果：100 件中 1-10 件</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
          <tr>
            <td>
              <div>yyyy/mm/dd hh:mm</div>
              <div>XXXX祭り</div>
            </td>
          </tr>
        </tbody>
      </table>
      <nav>
        <ul class="pager">
          <li class="previous disabled"><a href="javascript:void(0);"><span aria-hidden="true">&larr;</span> 前へ</a></li>
          <li class="next"><a href="javascript:void(0);">次へ <span aria-hidden="true">&rarr;</span></a></li>
        </ul>
      </nav>
    </div>
    <div class="col-lg-9" id="map"></div>
  </div>

  <script>

    var $mapEl = $(this.map);
    var checkVisible = setInterval(function(){
      if(!$mapEl.length || !$mapEl.is(':visible')){
        return;
      }
      clearInterval(checkVisible);

      var map = L.map($mapEl[0]).setView([35.6098733,140.1138984], 13);

      L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png", {
        maxZoom: 18,
        attribution: "<a href='http://www.gsi.go.jp/kikakuchousei/kikakuchousei40182.html' target='_blank'>国土地理院</a>",
        opacity: 0.8
      }).addTo(map);

    },50);
  </script>

  <style>
    #map { height: 500px; }
  </style>
</fes-list>
