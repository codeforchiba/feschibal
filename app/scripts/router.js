/**
 * riot.routeの機能拡充
 */
(function () {
  // ルーティングパースの変更
  riot.route.parser(function (path) {
    var raw = path.split('?'),
      uri = [raw[0]],
      qs = raw[1],
      params = {}

    if (qs) {
      qs.split('&').forEach(function (v) {
        var c = v.split('=')
        params[c[0]] = c[1]
      })
    }

    uri.push(params)
    return uri
  });

  // ページ遷移をイベント発行で通知する機能を追加
  riot.observable(riot.route);
  var currentFragment = '';
  var currentParam = null;
  var routes = function (fragment, param) {
    fragment = fragment || 'home'; // デフォルトはＨＯＭＥ画面
    var paths = fragment.split('/');
    var currentPaths = currentFragment.split('/');
    var routePath = '';
    for (var i = 0; i < paths.length; i++) {
      var nextPath = paths[i];
      var currentPath = currentPaths[i];
      if (nextPath !== currentPath) {
        changeView(routePath, nextPath, param);
        routePath += (routePath === '' ? '' : '/') + nextPath;
      } else if (!_.isEqual(param, currentParam)) {
        routePath += (routePath === '' ? '' : '/') + nextPath;
        riot.route.trigger(routePath, param);
      } else {
        routePath += (routePath === '' ? '' : '/') + nextPath;
      }
    }

    currentFragment = fragment;
    currentParam = param;
  };

  /**
   * 画面の切り替え
   * fadeOut -> スクロール位置のリセット -> fadeIn
   * @type {boolean}
   */
  var isAnimating = false;
  var changeView = function(routePath, nextPath, param){
    var $doc = $('body');
    if(isAnimating){
      riot.route.trigger('routeChange'+(routePath === '' ? '' : ':')+routePath, nextPath);
      routePath += (routePath === '' ? '' : '/') + nextPath;
      riot.route.trigger(routePath, param);
    } else {
      isAnimating = true;
      $doc.fadeOut(100, function(){
        riot.route.trigger('routeChange'+(routePath === '' ? '' : ':')+routePath, nextPath);
        $doc.scrollTop(0);
        $doc.fadeIn(function(){
          isAnimating = false;
        });
        routePath += (routePath === '' ? '' : '/') + nextPath;
        riot.route.trigger(routePath, param);
      });
    }
  };

  /**
   * 指定したエレメントが画面に表示されたタイミングでハンドラーをコールします。
   * @param event
   * @param el
   * @param handler
   */
  riot.route.onAttached = function(event, el, handler){
    this.on(event, function(param){
      el = $(el);
      var checkVisible = setInterval(function(){
        if(!el.length || !el.is(':visible')){
          return;
        }
        clearInterval(checkVisible);
        handler(param);
      },50);
    });
  };
  riot.route(routes);
  riot.route.build = function () {
    $('body').hide();
    this.exec(routes);
  };
})();
