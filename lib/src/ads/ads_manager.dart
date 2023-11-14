import 'package:logging/logging.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:word_rush/src/ads/ad_helper.dart';

final _log = Logger('ads_manager.dart');

class AdManager {
  // TODO: Initialize Unity ads

  Future<void> initialize() async {
    await UnityAds.init(
      gameId: AdHelper.gameID,
      onComplete: () {
        _log.info('Unity ads has been initialised sucessfully');
        print('Unity ads has been initialized.');
      },
      onFailed: (error, errorMessage) {
        _log.warning('Unity ads initialization failed');
        print('Unity ads failed initialized.');
      },
    );
  }

  // TODO: preload Interstitial ads
  static Future<void> preloadInterstitialAd() async {
    await UnityAds.load(
      placementId: AdHelper.interstitialID,
      onComplete: (placementId) {
        // _log.info(
        //     'Interstitial ad pre-loaded completely with placement id: $placementId');
        print(
            'Interstitial ad pre-loaded completely with placement id: $placementId');
      },
      onFailed: (placementId, error, errorMessage) {
        // _log.info(
        //   'Interstitial ad Failed to preload with placement id: $placementId and error message: $errorMessage',
        //   error,
        //   StackTrace.current,
        // );
        print(
          'Interstitial ad Failed to preload with placement id: $placementId and error message: $errorMessage, $error',
        );
      },
    );
  }

// TODO: Preload Rewarded ads
  static Future<void> preloadRewardedAds() async {
    await UnityAds.load(
      placementId: AdHelper.rewardedID,
      // onComplete: (placementId) => _log.info(
      //     'Rewarded ad loaded completely with placement id: $placementId'),
      // onFailed: (placementId, error, errorMessage) => _log.info(
      //   'Failed to preload Rewarded ads with the placement id: $placementId with error message $errorMessage',
      //   error,
      //   StackTrace.current,
      // ),

      onComplete: (placementId) {
        // _log.info(
        //     'Interstitial ad pre-loaded completely with placement id: $placementId');
        print(
            'Rewarded ad pre-loaded completely with placement id: $placementId');
      },
      onFailed: (placementId, error, errorMessage) {
        // _log.info(
        //   'Interstitial ad Failed to preload with placement id: $placementId and error message: $errorMessage',
        //   error,
        //   StackTrace.current,
        // );
        print(
          'Rewarded  ad Failed to preload with placement id: $placementId and error message: $errorMessage, $error',
        );
      },
    );
  }

  // TODO: Preload Banner Ad

  static Future<void> preloadBannerAd() async {
    await UnityAds.load(
      placementId: AdHelper.bannerID,
      onComplete: (placementId) =>
          print('Banner ads Has been preloaded Sucessfully'),
      onFailed: (placementId, error, errorMessage) => print(
          'Banner Ad failed to load with the error message $errorMessage, and error: $error'),
    );
  }

  //  TODO: show interstitial ads

  static Future<void> showInterstitialAd() async {
    await UnityAds.showVideoAd(
        placementId: AdHelper.interstitialID,
        onStart: (placementId) {
          print('video ad with placement id: $placementId started');
        },
        onClick: (placementId) {
          print('video ad with placement id: $placementId clicked');
        },
        onComplete: (placementId) async {
          await preloadInterstitialAd();
          // _log.info('video ad with placement id: $placementId completed');
        },
        onFailed: (placementId, error, errorMessage) async {
          await preloadInterstitialAd();
          // _log.info(
          //   'video ad with placement id: $placementId failed with error message: $errorMessage',
          //   error,
          //   StackTrace.current,
          // );
        },
        onSkipped: (placementId) {
          print('video ad with placement id: $placementId skipped');
        });
  }

  //  TODO: show rewarded ads

  static Future<void> showRewardedAds() async {
    await UnityAds.showVideoAd(
        placementId: AdHelper.rewardedID,
        onStart: (placementId) {
          print('video ad with placement id: $placementId started');
        },
        onClick: (placementId) {
          print('video ad with placement id: $placementId clicked');
        },
        onComplete: (placementId) async {
          await preloadInterstitialAd();
          // _log.info('video ad with placement id: $placementId completed');
        },
        onFailed: (placementId, error, errorMessage) async {
          await preloadInterstitialAd();
          // _log.info(
          //   'video ad with placement id: $placementId failed with error message: $errorMessage',
          //   error,
          //   StackTrace.current,
          // );
        },
        onSkipped: (placementId) {
          print('video ad with placement id: $placementId skipped');
        });
  }
}
