<app>
  <app-header></app-header>
  <div>
    <home if={ page === 'home' }></home>
    <search if={ page === 'search' } restype={restype} searchparam={searchparam}></search>
  </div>
  <app-footer></app-footer>

  <script>
    /** 表示ページキー */
    this.page = null;
    /** 結果表示ページキー */
    this.restype = null;
    /** 検索条件 */
    this.searchparam = null;

    // ルーティングパースの変更
    riot.route.parser(function(path) {
      var raw = path.split('?'),
        uri = raw[0].split('/'),
        qs = raw[1],
        params = {}

      if (qs) {
        qs.split('&').forEach(function(v) {
          var c = v.split('=')
          params[c[0]] = c[1]
        })
      }

      uri.push(params)
      return uri
    });

    // ルーティング設定
    var self = this;
    var routes = function() {
      if(arguments[0] === 'list' || arguments[0] === 'cal'){
        self.page = 'search';
        self.restype = arguments[0];
        self.searchparam = arguments[1];
      } else {
        self.page = 'home';
      }
      self.update();
    };
    riot.route(routes);
    riot.route.exec(routes);
  </script>
</app>
