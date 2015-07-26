riot.tag("pager",'<nav><ul class="pager"><li class="{previous: true, disabled: isDisablePreviousBtn}" ><a href="javascript:void(0);" onclick="{onClickBeforePage}" ><span aria-hidden="true">&larr;</span> 前へ</a></li><li class="{next:true, disabled: isDisableNextBtn}"><a href="javascript:void(0);" onclick="{onClickNextPage}">次へ <span aria-hidden="true">&rarr;</span></a></li></ul></nav>',function(a){var b=this;this.isDisablePreviousBtn=!1,this.isDisableNextBtn=!1,this.onClickBeforePage=function(){b.isDisablePreviousBtn||a.listener.onPageChange(a.result.pageNo-1)}.bind(this),this.onClickNextPage=function(){b.isDisableNextBtn||a.listener.onPageChange(a.result.pageNo+1)}.bind(this),this.on("update",function(){b.isDisablePreviousBtn=0===a.result.pageNo,b.isDisableNextBtn=a.result.total<=a.result.limit*(a.result.pageNo+1)})}),riot.tag("app","<app-header></app-header><home show=\"{path === 'home'}\"></home><search show=\"{path === 'search'}\"></search><fes-detail show=\"{path === 'detail'}\"></fes-detail><app-footer></app-footer>",function(a){var b=this;this.path=null,this.fes=null,riot.route.on("routeChange",function(a){b.path=a,b.update()})}),riot.tag("app-header",'<header><div class="header-content"><h1><a class="roll_fout" href="#"><img src="images/common/04c504f7.logo.png" alt="千葉市お祭りデータセンター"></a></h1></div></header>',"app-header header { background-color: #fff; } app-header h1 { padding: 10px 0px; } app-header .header-content { width: 1000px; margin: 0 auto; } @media only screen and (max-width: 640px) { app-header h1 { padding: 10px 0px 10px 10px; } app-header h1 img { width: 70%; } app-header .header-content { width: 100%; } }",function(a){}),riot.tag("app-footer",'<footer><p><img src="images/common/403c5bdd.codeforchiba.gif" alt="Code For Chiba"></p><p class="copyright">Copyright &copy; Code for Chiba All rights reserved.</p></footer>',"app-footer footer { background: #fff url(images/common/dc1f9a34.footer-line.gif) left top repeat-x; padding-top: 30px; } app-footer p { text-align: center; } app-footer .copyright { background: #2c2c2c; padding: 10px 0; color: #fff; margin-bottom: 0; } @media only screen and (max-width: 640px) { app-footer footer { background: #fff url(images/common/dc1f9a34.footer-line.gif) left top repeat-x; } app-footer p { text-align: center; } app-footer p img { width: 50%; } app-footer .copyright { background: #2c2c2c; padding: 20px 0; color: #fff; } }",function(a){}),riot.tag("home",'<div class="main"><div class="main-img"><img src="images/home/31ad2c57.main.jpg" alt="千葉市お祭りデータセンター"></div></div><article class="content"><section class="homesearch"><div class="homesearch-list"><a href="javascript:void(0)" onclick="{doClickCitySearchPanel}"><img src="images/home/fcec89ac.icon01.svg"><p>地域から探す</p></a></div><div class="homesearch-list"><a href="javascript:void(0)" onclick="{doSearchToday}"><img src="images/home/be0e5f45.icon02.svg"><p>本日開催の祭り</p></a></div><div class="homesearch-list"><a href="javascript:void(0)" onclick="{doSearchThisWeekEnd}"><img src="images/home/7843840a.icon03.svg"><p>土日開催の祭り</p></a></div></section><section id="city-search" style="display:none"><ul class="homesearch"><li class="homesearch-list" each="{city in cities}"><a href="javascript:void(0)" onclick="{parent.doSearchCity}"><p>{city.city}</p><p>{parent.fesCount[city.cityCode]}件</p></a></li></ul></section><section class="week"><dl class="week-day"><dt>今週開催の祭り</dt><dd>{moment(startDateOfWeek).format(\'M/D\')} - {moment(endDateOfWeek).format(\'M/D\')}</dd></dl><div class="week-map"><fes-map feslist="{fesList}"></fes-map></div><fes-list feslist="{fesList}"></fes-list></section></article>',"home .homesearch { background: #f5ac42; margin-bottom: 30px; } home .homesearch .homesearch-list { float: left; width: 33.2%; border-right: #cb7e01 solid 1px; font-size: 20px; font-weight: bold; text-align: center; } home .homesearch .homesearch-list:nth-child(3n) { border-right: 0px; } home .homesearch .homesearch-list a { display: block; color: #fff; padding: 20px 0px; text-decoration: none; } home .homesearch .homesearch-list a img{ width: 100px; } home .homesearch .homesearch-list a p { margin-bottom: 0px; } home .homesearch .homesearch-list a:hover { background: #ff9700; } home .homesearch .homesearch-list:last-child { border-right: none; } home .homesearch #city-search .homesearch-list { display: inline-block; float: none; border-top: #cb7e01 solid 1px; } home .homesearch:after { content: \".\"; display: block; height: 0; font-size: 0; clear: both; visibility: hidden; } home #city-search .homesearch-list { border-top: #cb7e01 solid 1px; } home #city-search .homesearch-list:nth-child(1),home #city-search .homesearch-list:nth-child(2),home #city-search .homesearch-list:nth-child(3){ border-top: 0; } home .week .week-day { margin-bottom: 30px; } home .week .week-day dt { font-size: 20px; font-weight: bold; text-align: center; } home .week .week-day dd { font-size: 36px; font-family: sans-serif; text-align: center; padding-bottom: 20px; font-weight: 400; font-family: 'Merriweather', serif; letter-spacing: 0.1em; background: url(images/common/00b976b5.week-day-bg01.gif) top 18px left 200px no-repeat, url(images/common/00b976b5.week-day-bg01.gif) top 18px right 200px no-repeat, url(images/common/12771e09.week-day-bg02.gif) center bottom 0px no-repeat; } home .week .week-map { margin-bottom: 30px; } home .week .week-map #map-result { height: 240px; width: 100%; } @media only screen and (max-width: 640px) { home .homesearch .homesearch-list { width: 33.1%; font-size: 14px; } home .homesearch .homesearch-list a { padding: 10px 0px; } home .homesearch .homesearch-list a img { width: 40%; } home .week .week-day dt { font-size: 14px; } home .week .week-day dd { font-size: 28px; background: url(images/common/00b976b5.week-day-bg01.gif) top 11px left -60px no-repeat, url(images/common/00b976b5.week-day-bg01.gif) top 11px right -60px no-repeat, url(images/common/12771e09.week-day-bg02.gif) center bottom 0px no-repeat; } }",function(a){var b=this;this.fesList=[],this.cities=[],this.fesCount={a:"b"},this.startDateOfWeek=moment().weekday(1).toDate(),this.endDateOfWeek=moment().weekday(7).toDate(),this.doClickCitySearchPanel=function(a){$(b["city-search"]).slideToggle()}.bind(this),this.doSearchToday=function(a){var b=moment().format("YYYY-MM-DD"),c={fromDate:b,toDate:b};riot.route("search/list?"+$.param(c))}.bind(this),this.doSearchThisWeekEnd=function(a){var b={fromDate:moment().weekday(6).format("YYYY-MM-DD"),toDate:moment().weekday(7).format("YYYY-MM-DD")};riot.route("search/list?"+$.param(b))}.bind(this),this.doSearchCity=function(a){var b=moment().format("YYYY-MM-DD"),c={fromDate:b,cities:[a.item.city.cityCode]};riot.route("search/list?"+$.param(c))}.bind(this),riot.route.on("home",function(a){b.tags["fes-map"].trigger("show");var c={fromDate:b.startDateOfWeek,toDate:b.endDateOfWeek,order:"periods"};cfc.Event.find(c).done(function(a){b.fesList=a.list,b.update()}),cfc.City.findAllWards().then(function(a){b.cities=a;var c=_.map(a,function(a){var c={fromDate:new Date,cities:[a.cityCode]};return cfc.Event.find(c).done(function(c){b.fesCount[a.cityCode]=c.total})});$.when.apply($,c).done(function(){b.update()})})})}),riot.tag("search",'<div class="main"><div class="main-img"><h2>祭りを検索する</h2><img src="images/home/31ad2c57.main.jpg" alt="千葉市お祭りデータセンター"></div></div><article class="content"><form onsubmit="{onSubmitSearch}"><h4>期間を選択してください。</h4><div class="form-group row"><div class="col-xs-6"><input type="text" class="form-control" id="fromDate" ></div><div class="col-xs-6"><input type="text" class="form-control" id="toDate" ></div></div><h4>地域を選択してください。</h4><div class="form-group"><select class="form-control"><option >-</option><option each="{city, i in cities}" onclick="{onSelectCity}">{city.city}{city.address}</option></select></div><div class="form-group btn-area"><button type="submit" class="btn btn-search">検索する</button></div></form><section class="result"><ul class="tab"><li class="{\'tab-item\': true, active: path===\'list\'}"><a href="#search/list?{queryString}"><img src="images/search/7d56a92a.icon01.svg"><p>一覧</p></a></li><li class="{\'tab-item\': true, active: path===\'map\'}"><a href="#search/map?{queryString}"><img src="images/search/7966085c.icon02.svg"><p>地図</p></a></li><li class="{\'tab-item\': true, active: path===\'cal\'}"><a href="#search/cal?{queryString}"><img src="images/search/9b96e6ed.icon03.svg"><p>カレンダー</p></a></li></ul><div><search-list show="{path===\'list\'}" request="{request}" ></search-list><search-map show="{path===\'map\'}" request="{request}" ></search-map><search-calendar show="{path===\'cal\'}" request="{request}" ></search-calendar></div></section></article>','search .main .main-img h2 { position: absolute; top: 80px; left: 0px; font-size: 36px; color: #fff; padding: 10px; padding-left: 20px; background-color: rgba(51, 51, 51, 0.6); } search .content { position: relative; } search form { padding: 20px 20px 0px 20px; background-color: rgba(255, 255, 255, 0.8); border: 2px solid #f5ac42; } search form .btn-area { text-align: center; } search form .btn-search { background-color: #3bb3e0; padding: 10px; position: relative; text-decoration: none; color: #fff; width: 100px; border: none; margin-bottom: 30px; background-image: linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%); background-image: -webkit-linear-gradient(bottom, #2ca0ca 0%, #3eb8e5 100%); background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, #2ca0ca), color-stop(1, #3eb8e5)); -o-box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785; box-shadow: inset 0px 1px 0px #7fd2f1, 0px 6px 0px #156785; border-radius: 5px; } search form .btn-search:active { color: #156785; text-shadow: 0px 1px 1px rgba(255, 255, 255, 0.3); background: #2ca0ca; -o-box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785; box-shadow: inset 0px 1px 0px #7fd2f1, inset 0px -1px 0px #156785; top: 7px; } search form .btn:active:before { top: -2px; } search form .btn:hover { color: #fff; } search .tab { background: #D75247; margin-bottom: 30px; } search .tab .tab-item { float: left; width: 33.1%; border-right: #8B332C solid 1px; font-size: 20px; font-weight: 700; text-align: center; } search .tab .tab-item a { display: block; color: #fff; padding: 20px 0; text-decoration: none; } search .tab .tab-item a img { width: 100px; } search .tab .tab-item a p { margin-bottom: 0; } search .tab .tab-item a:hover,search .tab .tab-item.active a { background: #BB463C; } search .tab .tab-item:last-child,search .tab .tab-item:nth-of-type(3n) { border-right: none; } search .tab:after { content: "."; display: block; height: 0; font-size: 0; clear: both; visibility: hidden; } @media all and (min-width: 641px) { search form { box-shadow: 0px 0px 10px; position: absolute; top: -270px; right: 50px; } } @media only screen and (max-width: 640px) { search .main .main-img h2 { top: 40px; font-size: 26px; padding-left: 10px; } search form { padding: 10px 10px 0px 10px; margin-left: 0px; margin-right: 0px; background-color: #f5ac42; border: none; } search form h4{ font-size: 13px; color: #fff; } search form .btn-search{ padding: 10px; position: relative; text-decoration: none; color: #fff; width: 100%; border: none; background-image: linear-gradient(bottom, #C53333 0%, #ED6060 100%); background-image: -webkit-linear-gradient(bottom, #C53333 0%, #ED6060 100%); background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, #C53333), color-stop(1, #ED6060)); -o-box-shadow: inset 0px 1px 0px #BB3535, 0px 6px 0px #901818; box-shadow: inset 0px 1px 0px #BB3535, 0px 6px 0px #901818; border-radius: 5px; } search form .btn-search:active { background: #C53333; color: #999; -o-box-shadow: inset 0px 1px 0px #BB3535, 0px -1px 0px #901818; box-shadow: inset 0px 1px 0px #BB3535, 0px -1px 0px #901818; top: 7px; } search form .btn-area { margin-bottom: 0; } search .tab{ margin-bottom:0px; } search .tab .tab-item{ font-size: 16px; } }',function(a){var b=this,c={format:"yyyy/mm/dd",language:"ja",orientation:"top",todayHighlight:!0,autoclose:!0,clearBtn:!0,weekStart:2};$(this.fromDate).datepicker(c),$(this.toDate).datepicker(c),this.cities=[],this.request=riot.observable(),this.path=null,this.queryString=null,cfc.City.findAll().then(function(a){_.each(a,function(a){b.cities.push(a)})}),this.onSubmitSearch=function(a){var b=riot.route.currentPath(),c={fromDate:$(this.fromDate).val().replace(/\//g,"-"),toDate:$(this.toDate).val().replace(/\//g,"-")};b+="?"+$.param(c),riot.route(b)}.bind(this),riot.route.on("routeChange:search",function(a){b.path=a,b.update()}),riot.route.on("search",function(a){b.queryString=$.param(a),a.fromDate&&$(b.fromDate).datepicker("update",new Date(a.fromDate)),a.toDate&&$(b.toDate).datepicker("update",new Date(a.toDate)),b.update()})}),riot.tag("search-list",'<fes-list feslist="{result.list}"></fes-list>',function(a){var b=this;this.result={},this.searchParam={},this.onSelectFes=function(a){riot.route("detail/"+a.item.fes.id)}.bind(this),this.listener={onPageChange:function(a){var c=b.searchParam.fromDate,d=b.searchParam.toDate,e={fromDate:c?moment(c).format("YYYY-MM-DD"):null,toDate:d?moment(d).format("YYYY-MM-DD"):null,pageNo:a};riot.route("search/list?"+$.param(e))}},riot.route.on("search/list",function(a){var c={pageNo:a.pageNo||0,fromDate:a.fromDate?new Date(a.fromDate):null,toDate:a.toDate?new Date(a.toDate):null,cities:a.cities,order:"periods"};cfc.Event.find(c).done(function(a){b.result=a,b.update()})})}),riot.tag("search-map",'<fes-map feslist="{feslist}"></fes-map>',"search-map #map-result { height: 500px; }",function(a){var b=this;this.feslist=[],riot.route.on("search/map",function(a){b.tags["fes-map"].trigger("show");var c={fromDate:a.fromDate?new Date(a.fromDate):null,toDate:a.toDate?new Date(a.toDate):null,cities:a.cities};cfc.Event.find(c).done(function(a){b.feslist=a.list,b.update()})})}),riot.tag("search-calendar",'<div id="calendar"></div>',"search-calendar .fc-event { margin-bottom: 5px; padding: 5px; cursor: pointer; } search-calendar .fc-event:hover { opacity: 0.8; } search-calendar .fc-event .fc-content { white-space: normal; } search-calendar .fc-event .fc-content .fc-time { display: block; } search-calendar .fc-sat { background-color:#FFF5F5; } search-calendar .fc-sun { background-color:#FFF5F5; }",function(a){var b=$(this.calendar);b.fullCalendar({lang:"ja",timezone:"local",firstDay:2,eventClick:function(a,b,c){return riot.route("detail/"+a.fes.id),!1}}),riot.route.on("search/cal",function(a){var b={fromDate:a.fromDate?new Date(a.fromDate):null,toDate:a.toDate?new Date(a.toDate):null,cities:a.cities};cfc.Event.find(b).done(c)});var c=function(a){var c=_.map(a.list,function(a){return{title:a.name,start:a.getStartDate().getTime(),end:a.getEndDate().getTime(),fes:a}});b.fullCalendar("render"),b.fullCalendar("removeEvents"),b.fullCalendar("addEventSource",c)}}),riot.tag("fes-detail",'<div if="{fes != null}"><div class="main"><div class="main-img"><img src="images/home/31ad2c57.main.jpg" alt="千葉市お祭りデータセンター"></div></div><article class="content"><div class="info-area"><h4 class="detail-title">{fes.name}</h4><ul class="day-time"><li each="{period, i in fes.periods}"><span class="date">{moment(period.start).format(\'MM/DD\')}</span><span class="{day-of-week:true,sat:6===period.start.getDay(),sun:0===period.start.getDay()}">{moment(period.start).format(\'dd\')}</span><span class="clock">{moment(period.start).format(\'HH:mm\')} - {moment(period.end).format(\'HH:mm\')}</span></li></ul><div class="features"><img if="{fes.features.dancing}" src="images/detail/5d84ee3e.Detail_icon01.svg"><img if="{fes.features.singing}" src="images/detail/359f9b9d.Detail_icon02.svg"><img if="{fes.features.drum}" src="images/detail/8c8fc759.Detail_icon03.svg"><img if="{fes.features.musicalPerformance}" src="images/detail/2ed5963e.Detail_icon04.svg"><img if="{fes.features.foodTruck}" src="images/detail/762ec244.Detail_icon05.svg"><img if="{fes.features.fireworks}" src="images/detail/f3c0c8cb.Detail_icon06.svg"></div><dl class="fes-infos"><dt>会 場</dt><dd>{fes.location.name}</dd><dt>住 所</dt><dd>{fes.location.city}{fes.location.address}</dd><dt>内 容</dt><dd><ul><li><span if="{fes.features.dancing}">踊り </span><span if="{fes.features.singing}">歌唱 </span><span if="{fes.features.drum}">太鼓 </span><span if="{fes.features.musicalPerformance}">演奏 </span><span if="{fes.features.foodTruck}">屋台 </span><span if="{fes.features.fireworks}">花火 </span></li><li each="{program in fes.features.others}">{program}</li><li each="{program in fes.features.specialProgram}">{program}</li></ul></dd><dt>備 考</dt><dd>この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。</dd></dl></div><div id="map-detail"></div><div class="title">周辺のお祭り</div><fes-list feslist="{aroundFes}"></fes-list></article></div>','fes-detail .info-area { margin-left: 10px; margin-right: 10px; } fes-detail .detail-title { color: #E39727; font-weight: bold; font-size: 36px; line-height: 1.2em; margin-bottom: 20px; } fes-detail .info-area .day-time { border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; margin-bottom: 30px; padding-bottom: 20px; padding-top: 20px; } fes-detail .info-area .day-time li { float: left; margin-right: 30px; } fes-detail .info-area .day-time .date { font-size: 26px; font-family: \'Merriweather\', serif; font-weight: 400; margin-right: 8px; } fes-detail .info-area .day-time .day-of-week { font-size: 18px; margin-right: 10px; } fes-detail .info-area .day-time .sat { color: #3aa3e6; } fes-detail .info-area .day-time .sun { color: #E10003; } fes-detail .info-area .day-time .clock { font-family: "Times New Roman", Times, serif; font-size: 24px; } fes-detail .info-area .day-time:after { content: "."; display: block; height: 0; font-size: 0; clear: both; visibility: hidden; } fes-detail .info-area .features { clear: both; margin-bottom: 30px; } fes-detail .info-area .features img { width: 120px; } fes-detail .info-area .fes-infos { clear: both; } fes-detail .info-area .fes-infos dt { float: left; border: solid 1px #A0A0A0; font-size: 13px; padding: 1px 30px; border-radius: 10px; } fes-detail .info-area .fes-infos dd { padding-left: 120px; margin-bottom: 20px; } fes-detail #map-detail { height: 250px; width: 100%; margin-bottom: 30px; } fes-detail .content .title { background-color: #F4A838; color: #ffffff; padding: 10px; font-size: 24px; margin-bottom: 30px; } @media only screen and (max-width: 640px) { fes-detail .info-area .detail-title { font-size: 28px; } fes-detail .info-area .features img { width: 33.3%; } fes-detail .info-area .fes-infos dt { float: none; text-align: center; margin-bottom: 10px; } fes-detail .info-area .fes-infos dd { padding-left: 0px; } }',function(a){var b=this;b.fes=null,b.aroundFes=[];var c=null,d=L.map(b["map-detail"],{dragging:!0});L.tileLayer("http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png",{maxZoom:18,subdomains:["otile1","otile2","otile3","otile4"],attribution:'Tiles courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">. Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'}).addTo(d),riot.route.on("routeChange:detail",function(a){cfc.Event.findOne(a).done(function(a){b.fes=a,b.update(),c&&d.removeLayer(c),c=L.marker([a.location.lat,a.location["long"]]),c.addTo(d),d.setView([a.location.lat,a.location["long"]],14),b.searchAroundRes(a)})}),this.searchAroundRes=function(a){var c=L.latLng([a.location.lat,a.location["long"]]),d={fromDate:new Date,basePoint:c,distance:5e3,limit:10,pageNo:0,order:"periods"};cfc.Event.find(d).done(function(c){b.aroundFes=_.filter(c.list,function(b){return a.id!==b.id}),b.update()})}.bind(this),this.onSelectFes=function(a){riot.route("detail/"+a.item.fes.id)}.bind(this)}),riot.tag("fes-list",'<ul class="festival-list"><li class="festival-list-date" each="{fes, i in opts.feslist}" onclick="{parent.onSelectFes}"><dl><dt><p class="day"><span class="bgcolor" each="{period in fes.periods}" > {moment(period.start).format(\'MM/DD\')} <span class="small">{moment(period.start).format(\'dd\')}</span></span></p><p class="title">{fes.name}</p></dt><dd><a href="javascript:void(0)"><img class="roll_fout" riot-src="{fes.getImage()}"></a></dd></dl></li></ul>',"fes-list .festival-list { padding: 0 20px; } fes-list .festival-list-date { width: 300px; float: left; margin-right: 30px; margin-bottom: 30px; } fes-list .festival-list-date .day { font-size: 26px; font-family: 'Merriweather', serif; font-weight: 400; color: #fff; margin-bottom: 3px; letter-spacing: 0.1em; } fes-list .festival-list-date .day .small { font-size: 18px; } fes-list .festival-list-date .day .bgcolor { background: #dc79a2; padding: 6px; margin-right: 5px; } fes-list .festival-list-date .title { background: #4c4c4c; padding: 8px; font-size: 26px; font-weight: bold; color: #fff; margin-bottom: 0; } fes-list .festival-list-date:nth-child(3n) { margin-right: 0px; } fes-list .festival-list:after { content: \".\"; display: block; height: 0; font-size: 0; clear: both; visibility: hidden; } @media only screen and (max-width: 640px) { fes-list .festival-list { padding: 0; } fes-list .festival-list-date { width: 100%; float: none; position: relative; margin-right: 0; margin-bottom: 1px; } fes-list .festival-list-date dt { position: absolute; top: 20px; left: 10px; } fes-list .festival-list-date dt .day { font-size: 18px; font-family: 'Merriweather', serif; font-weight: 400; color: #fff; margin-bottom: 5px; letter-spacing: 0.1em; } fes-list .festival-list-date dt .day .small { font-size: 14px; } fes-list .festival-list-date dt .day .bgcolor { background: #dc79a2; padding: 8px; } fes-list .festival-list-date dt .title { background: #4c4c4c; padding: 8px; font-size: 18px; font-weight: bold; color: #fff; margin-bottom: 0; } fes-list .festival-list-date dd { height: 110px; overflow: hidden; background: #383838; } fes-list .festival-list-date dd img { width: 100%; } fes-list .festival-list-date:nth-child(3n) { margin-right: 6%; } fes-list .festival-list-date:nth-child(2n) { margin-right: 0; } }",function(a){this.onSelectFes=function(a){riot.route("detail/"+a.item.fes.id)}.bind(this)}),riot.tag("fes-map",'<div id="map-result"></div>',function(a){function b(a,b){c.setView([a,b],12);var d=L.icon({iconUrl:"images/5005034b.icon_pointer.png",iconRetinaUrl:"images/5005034b.icon_pointer.png",iconSize:[35,35],iconAnchor:[17,17],popupAnchor:[0,0]}),e={icon:d,clickable:!1,draggable:!1,opacity:.9};L.marker([a,b],e).addTo(c)}var c=L.map(this["map-result"],{dragging:!0});L.tileLayer("http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png",{maxZoom:18,subdomains:["otile1","otile2","otile3","otile4"],attribution:'Tiles courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">. Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'}).addTo(c);var d=L.markerClusterGroup();d.addTo(c),this.on("show",function(){navigator.geolocation?navigator.geolocation.getCurrentPosition(function(a){b(a.coords.latitude,a.coords.longitude)},function(a){b(35.6098733,140.1138984)},{enableHighAccuracy:!0,timeout:8e3,maximumAge:0}):b(35.6098733,140.1138984)}),this.on("update",function(){d.clearLayers(),_.each(a.feslist,function(a){var b=L.marker(new L.LatLng(a.location.lat,a.location["long"])).bindLabel(a.name,{noHide:!0,clickable:!0});b.on("click",function(b){riot.route("detail/"+a.id)}),b.label.on("click",function(b){riot.route("detail/"+a.id)}),d.addLayer(b)})})}),function(){"use strict";riot.route.parser(function(a){var b=a.split("?"),c=[b[0]],d=b[1],e={};return d&&d.split("&").forEach(function(a){var b=a.split("=");if(b[0].indexOf("%5B%5D")>=0){var c=b[0].replace("%5B%5D","");e[c]||(e[c]=[]),e[c].push(b[1])}else e[b[0]]=b[1]}),c.push(e),c}),riot.route.currentPath=function(){var a=location.href.match(/#([^\?]*)/);return a.length>1?a[1]:""},riot.observable(riot.route);var a="",b=null,c=function(c,d){c=c||"home";var e=c.split("/"),f=a.split("/");m(function(){for(var g="",h=0;h<e.length;h++){var i=e[h],j=f[h];i!==j?(riot.route.trigger("routeChange"+(""===g?"":":")+g,i),g+=(""===g?"":"/")+i,riot.route.trigger(g,d)):_.isEqual(d,b)?g+=(""===g?"":"/")+i:(g+=(""===g?"":"/")+i,riot.route.trigger(g,d))}a=c,b=d})},d=navigator.userAgent.match(/Trident/)||navigator.userAgent.match(/MSIE/),e=!1,f="Webkit Moz O ms Khtml".split(" "),g=document.createElement("div");if(void 0!==g.style.animationName&&(e=!0),!e)for(var h=0;h<f.length;h++)if(void 0!==g.style[f[h]+"AnimationName"]){e=!0;break}var i={display:"block",opacity:0,position:"absolute",left:e?"0px":"20px",right:0,top:0,bottom:0},j={left:"0px",opacity:1},k={left:"",top:"",right:"",bottom:"",position:"",opacity:""},l=function(a){a.removeClass("entrance-in entrance-out")},m=function(a){var b=$("body"),c=function(){b.scrollTop(0),a&&a(),b.css(i),e?(l(b),b.addClass("entrance-in"),setTimeout(function(){l(b),b.css(k)},500)):b.animate(j,{duration:500,easing:"swing",always:function(){b.css(k)}})};e&&!d?(l(b),b.addClass("entrance-out"),setTimeout(c,100)):b.fadeOut({duration:100,always:c})};riot.route.attacheExec=function(a,b){a=$(a);var c=setInterval(function(){a.length&&a.is(":visible")&&(clearInterval(c),b())},50)},riot.route(c),riot.route.build=function(){$("body").hide(),this.exec(c)}}(),function(a){"use strict";var b=function(){};b.prototype={dataStore:null,findAll:function(){if(this.dataStore){var a=new $.Deferred;return a.resolve(_.values(this.dataStore)),a.promise()}var b=this;return this.getJSON(this.url).then(function(a){return b.dataStore={},b.storeData(a),_.values(b.dataStore)})},storeData:function(a){},findOne:function(a){var b=this;if(this.dataStore){var c=new $.Deferred,d=b.dataStore[a];return d?c.resolve(d):c.reject(),c.promise()}return this.findAll().then(function(){var c=new $.Deferred,d=b.dataStore[a];return d?c.resolve(d):c.reject(),c.promise()})},getJSON:function(a){return $.getJSON(a)},_jsonp:function(a,b){var c=document.createElement("script");c.async=!0;var d="exec"+Math.floor(65535*Math.random()+1);window[d]=function(a){var c=document.getElementById(d);c.parentNode.removeChild(c),b(a),window[d]=null,delete window[d]};var e=a.indexOf("?")>-1?"&":"?";c.src=a+e+"callback="+d,c.id=d,document.getElementsByTagName("head")[0].appendChild(c)}},a.StoreBase=b}(window.cfc=window.cfc||{}),function(a){"use strict";var b=function(){};b.prototype={url:"http://codeforchiba.github.io/feschibal/data/chiba_festival.json",storeData:function(a){_.each(a,function(a){a.periods=_.map(a.periods,function(a){return a.start=new Date(a.start),a.end=new Date(a.end),a}),this.dataStore[a.id]=new cfc.Event(a)},this)}},_.defaults(b.prototype,cfc.StoreBase.prototype),a.EventStore=b}(window.cfc=window.cfc||{}),function(a){"use strict";var b=function(){};b.prototype={url:"http://codeforchiba.github.io/feschibal/data/12chiba.json",storeData:function(a){_.each(a,function(a){this.dataStore[a.addressCode]=new cfc.City(a)},this)}},_.defaults(b.prototype,cfc.StoreBase.prototype),a.CityStore=b}(window.cfc=window.cfc||{}),function(a){"use strict";var b=function(a){return 1e4*a.getYear()+100*a.getMonth()+a.getDate()},c=function(a){for(var b in a)this[b]=a[b]};c.prototype={getStartDate:function(){return this.periods[0].start},getEndDate:function(){return this.periods[this.periods.length-1].end},getImage:function(){return this.image||"images/common/15953526.pic01.jpg"}},c.dataStore=new cfc.EventStore,c.findAll=function(){return this.dataStore.findAll()},c.find=function(a){return this.findAll().then(function(c){return _.filter(c,function(c){var d=!1;if(a.fromDate){var e=b(a.fromDate);if(d=_.some(c.periods,function(a){return b(a.end)>=e}),!d)return!1}if(a.toDate){var f=b(a.toDate);if(d=_.some(c.periods,function(a){return b(a.start)<=f}),!d)return!1}if(a.basePoint&&null!=a.distance){var g=L.latLng([c.location.lat,c.location["long"]]);if(c.distance=g.distanceTo(a.basePoint),c.distance>a.distance)return!1}if(a.cities&&a.cities.length>0){var d=_.some(a.cities,function(a){return c.location.addressCode.indexOf(a)>=0});if(!d)return!1}return!0})}).then(function(b){return null!=a.order&&"periods"===a.order?_.sortBy(b,function(a){return a.getStartDate().getTime()}):null!=a.order?_.sortBy(b,a.order):b}).then(function(b){if(null!=a.limit&&null!=a.pageNo){var c=a.limit*a.pageNo,d=a.limit*(a.pageNo+1)-1;return{total:b.length,limit:a.limit,pageNo:a.pageNo,list:_.filter(b,function(a,b){return b>=c&&d>=b})}}return{total:b.length,list:b}})},c.findOne=function(a){return this.dataStore.findOne(a)},a.Event=c}(window.cfc=window.cfc||{}),function(a){"use strict";var b=function(a){for(var b in a)this[b]=a[b]};b.prototype={getTowns:function(){var a=this;return b.dataStore.findAll().then(function(b){return _.filter(b,function(b){return b.addressCode.lastIndexOf("0000")<0&&a.cityCode===b.cityCode})})},isWard:function(){return this.addressCode.lastIndexOf("0000")>=0}},b.dataStore=new cfc.CityStore,b.findAll=function(){return this.dataStore.findAll()},b.findOne=function(a){return this.dataStore.findOne(a)},b.findAllWards=function(){return this.dataStore.findAll().then(function(a){return _.filter(a,function(a){return a.isWard()})})},a.City=b}(window.cfc=window.cfc||{});