import 'package:flutter/foundation.dart';

class AdHelper {
  // TODO: Get Unity Game ID

  static String get gameID {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '5471105';
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return '5471104';
    }

    return '5471105';
  }

  //TODO: set interstitial Video ID

  static String get interstitialID {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Interstitial_Android';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Interstitial_iOS';
    }
    return '';
  }

  // TODO: set rewarded InterstitialVideo.

  static String get rewardedID {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Rewarded_Android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Rewarded_iOS';
    }
    return '';
  }

  static String get bannerID {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'Banner_Android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'Banner_iOS';
    }
    return '';
  }
}
