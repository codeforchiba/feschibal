<announcement-list>
  <ul>
    <li class="clearfix" each={announcement in opts.list}>
      <h3>{announcement.title}</h3>
      <img src="{announcement.thumbnailUrl}" alt="" width="250" height="300" if={ thumbnailAvailable(announcement) }/>
      <p each={description in lineFeedSplit(announcement.description)}>{description}</p>
    </li>
  </ul>

  <script>
    lineFeedSplit(description){
      return description.split(/(?:\r\n|[\r\n])/);
    }

    thumbnailAvailable(announcement) {
      return "thumbnailUrl" in announcement;
    }
  </script>

  <style scoped>
    ul {
      width: 680px;
      margin: 0 auto;
    }

    ul li h3 {
      margin: 32px 0;
      padding: 8px 0;
      border: solid 2px #f7bd68;
      font-size: 17pt;
    }

    ul li h3:first-letter {
      margin: 5px 0 5px 10px;
      padding-left: 10px;
      border-left: 10px solid #f3a534;
    }

    ul li img {
      width: 250px;
      height: 300px;
      margin-right: 32px;
      margin-bottom: 32px;
      float: left;
    }

    @media only screen and (max-width: 640px) {
      ul {
        width: auto;
      }

      ul li {
        margin: 0 10px;
      }

      ul li h3 {
        margin: 12px 0;
        padding: 0 0 0 10px;
        border-width: 0;
        border-left: 10px solid #f3a534;
        font-size: 14pt;
      }

      ul li h3:first-letter {
        margin: 0;
        padding: 0;
        border-width: 0;
      }

      ul li img {
        float: none;
        margin: 16px auto;
      }
    }
  </style>
</announcement-list>
