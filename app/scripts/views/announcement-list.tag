<announcement-list>
  <div class="content_box">
    <div class="item" each={announcement,i in opts.announcementlist}>
      <h3>{announcement.title}</h3>
      <img src="{announcement.thumbnailUrl}" alt=""/>
      <p>{announcement.description}</p>
      <div style="clear:left;" />
    </div>
  </div>
  <script>
      cfc.Announcement.findAll().then(function(announcements) {
        self.announcements = announcements;
        self.update();
      });
  </script>
  <style scoped>
  .float {
    float:left;
    width:300px;
    height:200px;
    background: #999; 
  }

  .content_box {
    width: 680px;
    margin: 0 auto;
  }

  .item > h3 {
    font-size: 17pt;
    text-align: left;
    margin-bottom: 32px;
    margin-top: 32px;
    line-height: 44px;
    border: 2px solid #f5ac42;
  }

  .item > img {
    width: 250px;
    height: 300px;
    margin-right: 32px;
    margin-bottom: 32px;
    float: left;
  }

  .item > p {
    line-height: 1.7;
    margin-left: 32px;
    margin-bottom: 32px;
  }
  </style>
</announcement-list>
