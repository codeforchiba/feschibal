/**
 * riot.routeの機能拡充
 */
(function(){
  // ルーティングパースの変更
  riot.route.parser(function(path) {
    var raw = path.split('?'),
      uri = [raw[0]],
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

  // 現在のページパスを返す
  riot.route.currentPath = function(){
    var args = location.href.match(/#([^\?]*)/);
    return args.length > 1 ? args[1] : "";
  };

  // ページ遷移をイベント発行で通知する機能を追加
  riot.observable(riot.route);
  var currentFragment = '';
  var currentParam = null;
  var routes = function(fragment, param) {
    fragment = fragment || 'home'; // デフォルトはＨＯＭＥ画面
    var paths = fragment.split('/');
    var currentPaths = currentFragment.split('/');
    var routePath = '';
    for(var i = 0; i< paths.length; i++){
      var nextPath = paths[i];
      var currentPath = currentPaths[i];
      if(nextPath !== currentPath){
        riot.route.trigger('routeChange'+(routePath === '' ? '' : ':')+routePath, nextPath);
        routePath += (routePath === '' ? '' : '/') + nextPath;
        riot.route.trigger(routePath, param);
      } else if (!_.isEqual(param, currentParam)){
        routePath += (routePath === '' ? '' : '/') + nextPath;
        riot.route.trigger(routePath, param);
      } else {
        routePath += (routePath === '' ? '' : '/') + nextPath;
      }
    }

    currentFragment = fragment;
    currentParam = param;
  };
  riot.route(routes);
  riot.route.build = function(){
    this.exec(routes);
  };
})();
