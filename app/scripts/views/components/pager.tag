<pager>
  <nav>
    <ul class="pager">
      <li class={previous: true, disabled: isDisablePreviousBtn } ><a href="javascript:void(0);" onclick={onClickBeforePage} ><span aria-hidden="true">&larr;</span> 前へ</a></li>
      <li class={next:true, disabled: isDisableNextBtn}><a href="javascript:void(0);" onclick={onClickNextPage}>次へ <span aria-hidden="true">&rarr;</span></a></li>
    </ul>
  </nav>
  <script>
    var self  = this;
    this.isDisablePreviousBtn = false;
    this.isDisableNextBtn = false;

    /**
     * 前へボタン押下時
     */
    onClickBeforePage(){
      if(!self.isDisablePreviousBtn){
        opts.listener.onPageChange(opts.result.pageNo - 1);
      }
    }

    /**
     * 次へボタン押下時
     */
    onClickNextPage(){
      if(!self.isDisableNextBtn) {
        opts.listener.onPageChange(opts.result.pageNo + 1);
      }
    }

    /**
     * 画面更新時
     */
    this.on('update', function() {
      self.isDisablePreviousBtn = (opts.result.pageNo === 0 );
      self.isDisableNextBtn = (opts.result.total <= opts.result.limit * (opts.result.pageNo + 1 ));
    })
  </script>
</pager>
