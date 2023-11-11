import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:word_rush/src/ads/ad_helper.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UnityBannerAd(
      placementId: AdHelper.bannerID,
      size: BannerSize.standard,
      onLoad: (placementId) =>
          print('Banner add loaded Sucessfully with id: $placementId'),
      onClick: (placementId) => print(
          'Banner add Has been clicked sucessfully with the placement id: $placementId'),
      onShown: (placementId) => print('Banner add has been shown sucessfully'),
      onFailed: (placementId, error, errorMessage) => print(
          'Unable to show banner Ad with the placment id: $placementId, error message: $errorMessage, and error : $error'),
    );
  }
}
