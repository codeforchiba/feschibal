<search>
  <div class="context row">
    <div class="col-xs-3">
      検索条件入力
    </div>
    <div class="col-xs-9">
      <ul class="nav nav-tabs">
        <li role="presentation" class={active: opts.restype==='list'}><a href="#list?{$.param(opts.searchparam)}">一覧表示</a></li>
        <li role="presentation" class={active: opts.restype==='cal'}><a href="#cal?{$.param(opts.searchparam)}">カレンダー表示</a></li>
      </ul>
      <div>
        <fes-list if={ opts.restype === 'list' }></fes-list>
        <fes-calendar if={ opts.restype === 'cal' }></fes-calendar>
      </div>
    </div>
  </div>
  <script>

  </script>
</search>
