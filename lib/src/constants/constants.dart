const String imagePath = 'assets/images/';

extension ImageExtension on String {
  String get png => '$imagePath$this.png';
}

class GameConstant {
  static ImageConstants get images => ImageConstants();
}

class ImageConstants {
  String get backgroundImage => 'menu/bg'.png;
}
