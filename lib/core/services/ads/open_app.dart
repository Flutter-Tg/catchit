import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class OpenAdAdHelper {
  static AppOpenAd? appOpenAd;
  static bool isShowingAd = false;

  // final Duration maxCacheDuration = const Duration(hours: 4);
  // DateTime? _appOpenLoadTime;
  static String get unitId {
    // if (kReleaseMode) {
    //   if (Platform.isAndroid) {
    //     return '';
    //   } else {
    //     return '';
    //   }
    // } else {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else {
      return 'ca-app-pub-3940256099942544/5662855259';
    }
    // }
  }

  // Future showAd() async {
  //   await AppOpenAd.load(
  //     adUnitId: unitId,
  //     orientation: AppOpenAd.orientationPortrait,
  //     request: const AdRequest(),
  //     adLoadCallback: AppOpenAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         debugPrint('AppOpenAd : load');
  //         _appOpenLoadTime = DateTime.now();
  //         appOpenAd = ad;
  //         appOpenAd!.show();
  //       },
  //       onAdFailedToLoad: (error) {
  //         debugPrint('AppOpenAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  Future loadAd() async {
    // if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
    //   appOpenAd?.dispose();
    //   appOpenAd = null;
    // }
    if (isShowingAd == false) {
      isShowingAd = true;
      await AppOpenAd.load(
        adUnitId: unitId,
        orientation: AppOpenAd.orientationPortrait,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('AppOpenAd : load');
            // _appOpenLoadTime = DateTime.now();
            appOpenAd = ad;
            appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdFailedToShowFullScreenContent: (ad, error) {
                isShowingAd = false;
                ad.dispose();
                appOpenAd = null;
              },
              onAdDismissedFullScreenContent: (ad) {
                isShowingAd = false;
                ad.dispose();
                appOpenAd = null;
              },
              onAdWillDismissFullScreenContent: (ad) {
                isShowingAd = false;
              },
            );
            appOpenAd!.show();
          },
          onAdFailedToLoad: (error) {
            debugPrint('AppOpenAd failed to load: $error');
            isShowingAd = false;
          },
        ),
      );
    }
  }

  // bool get isAdAvailable {
  //   return appOpenAd != null;
  // }

  // showAdIfAvailable() async {
  //   isShowingAd = true;
  //   if (!isAdAvailable) {
  //     await loadAd();
  //     return;
  //   }
  //   if (isShowingAd) {
  //     return;
  //   }
  //   if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
  //     appOpenAd!.dispose();
  //     appOpenAd = null;
  //     loadAd();
  //     return;
  //   }

  //   // appOpenAd!.show();
  // }
}
