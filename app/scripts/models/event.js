(function(nm){
  /**
   * 祭りイベントオブジェクト
   *
   * @constructor
   */
  var Event = function(){

  };

  Event.prototype = {

    /** 祭りイベントＩＤ */
    id:null,
    /** 祭り名公開可否 */
    isExposeName: false,
    /** 祭り名 */
    name: null,

    /** 開催日時公開可否 */
    isExposeDate: false,
    /** 開始日時 */
    startDate: null,
    /** 終了日時 */
    endDate: null,

    /** 開催場所公開可否 */
    isExposePlace: false,
    /** 会場 */
    place: null,
    /** 住所 */
    address: null,
    /** 座標 */
    coordinates: null,

    /** 祭り内容公開可否 */
    isExposeContents: false,
    /** 踊り */
    hasDancing: false,
    /** 歌唱 */
    hasSinging: false,
    /** 太鼓 */
    hasDrum: false,
    /** 演奏 */
    hasMusicalPerformance: false,
    /** 屋台 */
    hasFoodStall: false,
    /** 花火 */
    hasFireworks: false,
    /** その他 */
    other: null,

    /** 祭りの目玉公開可否 */
    isExposeSpecialProgram: false,
    /** 祭りの目玉 */
    specialProgram: null,

    /** 一般参加可否の公開可否 */
    isExposeParticipation: false,
    /** 一般参加の可否 */
    canParticipate: false,

    /** 祭りサイト */
    officialSite: null,

    /** 主催団体の公開可否 */
    isExposeSponsor: false,
    /** 主催団体 */
    sponsorGroup: null,

    /** 問い合わせ先団体の公開可否 */
    isExposeContactGroup: false,
    /** 問い合わせ先団体 */
    contactGroup:null,

    /** 問い合わせ先担当者の公開可否 */
    isExposeContactPerson: false,
    /** 問い合わせ先担当者 */
    contactPerson: null,

    /** 問い合わせ先電話番号の公開可否 */
    isExposeContactTel: false,
    /** 問い合わせ先電話番号 */
    contactTel: null,

    /** 問い合わせ先メールアドレスの公開可否 */
    isExposeContactMail: false,
    /** 問い合わせ先メールアドレス */
    contactMail: null
  };

  /**
   * データストア
   */
  Event.dataStore = new feschibal.EventStore();

  /**
   * 祭りデータを全件返します。
   */
  Event.findAll = function(cb){
    this.dataStore.findAll(function(data){
      cb && cb(data);
    });
  }

  nm.Event = Event;
})(window.feschibal = window.feschibal || {});
