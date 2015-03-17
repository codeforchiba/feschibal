<home>
  home
  <button onclick={onClickSearchBtn}>検索</button>
  <script>

    onClickSearchBtn(e){
      riot.route('list?param1=value1&param2=value2');
    }

  </script>
</home>
