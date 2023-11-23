const String imagePath = 'assets/images/';

extension ImageExtension on String {
  String get png => '$imagePath$this.png';
}

class GameConstant {
  static ImageConstants get images => ImageConstants();
}

class ImageConstants {
  String get backgroundImage => 'menu/bg'.png;

  // TODO: All Game Buttons
  String get muteBtn => 'btn/musicoff'.png;

  String get musicOnBtn => 'btn/misic'.png;

  String get aboutBtn => 'btn/about'.png;

  String get closeBtn2 => 'btn/close_2'.png;

  String get closeBtn => 'btn/close'.png;

  String get faqBtn => 'btn/faq'.png;

  String get leaderBtn => 'btn/leader'.png;

  String get menuBtn => 'btn/menu'.png;

  String get nextBtn => 'btn/next'.png;

  String get okBtn => 'btn/ok'.png;

  String get pauseBtn => 'btn/pause'.png;

  String get playBtn => 'btn/play'.png;

  String get prevButton => 'btn/prew'.png;

  String get prizeBtn => 'btn/prize'.png;

  String get restartBtn => 'btn/restart'.png;

  String get settingsBtn => 'btn/settings'.png;

  String get shopBtn => 'btn/shop'.png;

  String get soundBtn => 'btn/sound'.png;

  String get soundOffBtn => 'btn/sound_off'.png;

  String get upgradeBtn => 'btn/upgrade'.png;

  // TODO: Settings Images

  String get settingBoard => 'settings/bg'.png;

  String get settingHeader => 'settings/92'.png;

  // TODO: Menu Images
  // TODO: store assets

  String get coinsIcon => 'shop/coin'.png;

  // TODO: MAtch3 assets
  String get boardHeader => 'match3/down'.png;

  //  TODO: bubbla assets
  String get btn => 'bubble/load'.png;
  String get zero => 'bubble/0'.png;
  String get one => 'bubble/1'.png;
  String get two => 'bubble/2'.png;
  String get three => 'bubble/3'.png;
  String get four => 'bubble/4'.png;
  String get five => 'bubble/5'.png;
  String get six => 'bubble/6'.png;
  String get seven => 'bubble/7'.png;
  String get eight => 'bubble/8'.png;
  String get nine => 'bubble/9'.png;
  String get star => 'bubble/star_1'.png;
  String get table => 'bubble/table'.png;
  String get clock => 'bubble/clock'.png;

  // TODO: level selectassets

  String get levelHeader => 'level_select/header'.png;
  String get levelTable1 => 'level_select/table'.png;
  String get levelLock => 'level_select/lock'.png;

  // TODO: clock
}
