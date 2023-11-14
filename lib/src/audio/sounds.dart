List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.failed:
      return [
        'failed.mp3',
      ];
    case SfxType.swiped:
      return [
        'game-swipe.mp3',
      ];
    case SfxType.select:
      return [
        'select.mp3',
      ];
    case SfxType.success:
      return [
        'success.mp3',
      ];
  }
}

double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.failed:
      return 1.0;
    case SfxType.swiped:
      return 1.0;
    case SfxType.select:
      return 1.0;
    case SfxType.success:
      return 1.0;
  }
}

enum SfxType {
  failed,
  swiped,
  select,
  success,
}
