/**
 * riot.routeの機能拡充
 */
(function () {
  'use strict';
  // ルーティングパースの変更
  riot.route.parser(function (path) {
    var raw = path.split('?'),
      uri = [raw[0]],
      qs = raw[1],
      params = {};

    if (qs) {
      qs.split('&').forEach(function (v) {
        var c = v.split('=');
        params[c[0]] = c[1];
      });
    }

    uri.push(params);
    return uri;
  });

  // 現在のページパスを返す
  riot.route.currentPath = function(){
    var args = location.href.match(/#([^\?]*)/);
    return args.length > 1 ? args[1] : '';
  };

  // ページ遷移をイベント発行で通知する機能を追加
  riot.observable(riot.route);
  var currentFragment = '';
  var currentParam = null;
  var routes = function (fragment, param) {
    fragment = fragment || 'home'; // デフォルトはＨＯＭＥ画面
    var paths = fragment.split('/');
    var currentPaths = currentFragment.split('/');

    changeView(function(){
      var routePath = '';
      for (var i = 0; i < paths.length; i++) {
        var nextPath = paths[i];
        var currentPath = currentPaths[i];
        if (nextPath !== currentPath) {
          riot.route.trigger('routeChange'+(routePath === '' ? '' : ':')+routePath, nextPath);
          routePath += (routePath === '' ? '' : '/') + nextPath;
          riot.route.trigger(routePath, param);
        } else if (!_.isEqual(param, currentParam)) {
          routePath += (routePath === '' ? '' : '/') + nextPath;
          riot.route.trigger(routePath, param);
        } else {
          routePath += (routePath === '' ? '' : '/') + nextPath;
        }
      }
      currentFragment = fragment;
      currentParam = param;
    });
  };

  /**
   * 画面の切り替え
   * fadeOut -> スクロール位置のリセット -> slideIn
   * @type {boolean}
   */
  var isIE = navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/MSIE/);
  var animation = false,
    domPrefixes = 'Webkit Moz O ms Khtml'.split(' '),
    elm = document.createElement('div');

  if(elm.style.animationName !== undefined) {
    animation = true;
  }
  if(!animation) {
    for(var i = 0; i < domPrefixes.length; i++) {
      if(elm.style[domPrefixes[i] + 'AnimationName'] !== undefined) {
        animation = true;
        break;
      }
    }
  }
  var startValues = {
    display: 'block',
    opacity: 0,
    position: 'absolute',
    left: animation ? '0px' : '20px',
    right: 0,
    top: 0,
    bottom: 0
  };
  var endValues = {
    left: '0px',
    opacity: 1
  };
  var clearValues = {
    left: '',
    top: '',
    right: '',
    bottom:'',
    position:'',
    opacity: ''
  };
  var removeAnimationClasses = function($el){
    $el.removeClass('entrance-in entrance-out');
  };
  var changeView = function(cb){
    var $doc = $('body');
    var startTransition = function() {
      $doc.scrollTop(0);
      if(cb){
        cb();
      }
      $doc.css(startValues);
      if (animation) {
        removeAnimationClasses($doc);
        $doc.addClass('entrance-in');
        setTimeout(function () {
          removeAnimationClasses($doc);
          $doc.css(clearValues);
        }, 500);
      } else {
        $doc.animate(endValues, {
          duration: 500,
          easing: 'swing',
          always: function() {
            $doc.css(clearValues);
          }
        });
      }
    };
    if (animation && !isIE) {
      removeAnimationClasses($doc);
      $doc.addClass('entrance-out');
      setTimeout(startTransition, 100);
    } else {
      $doc.fadeOut({ duration: 100, always: startTransition });
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
