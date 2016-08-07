<announcement-list>
  <div class="content_box">
    <div class="item clearfix" each={announcement in opts.announcementlist}>
      <h3>{announcement.title}</h3>
      <img src="{announcement.thumbnailUrl}" alt="" width="250" height="300" if={announcement.thumbnailUrl != ''}/>
      <p each={description in lineFeedSplit(announcement.description)}>{description}</p>
    </div>
  </div>
  <script>
      cfc.Announcement.findAll().then(function(announcements) {
        self.announcements = announcements;
        self.update();
      });

      lineFeedSplit(description){
        return description.split(/(?:\r\n|[\r\n])/);
      }
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
  </style>
</announcement-list>
