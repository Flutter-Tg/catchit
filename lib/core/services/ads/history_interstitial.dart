import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HistoryInterstitialHelper {
  static bool inShowing = false;
  static InterstitialAd? interstitialAd;
  static String get unitId {
    // if (kReleaseMode) {
    //   if (Platform.isAndroid) {
    //     return '';
    //   } else {
    //     return '';
    //   }
    // } else {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    // }
  }

  Future loadAd() async {
    if (inShowing = false) {
      inShowing = true;
      await InterstitialAd.load(
        adUnitId: unitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) => inShowing = true,
              onAdImpression: (ad) => inShowing = true,
              onAdFailedToShowFullScreenContent: (ad, err) {
                inShowing = false;
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                inShowing = false;
                ad.dispose();
              },
              onAdClicked: (ad) => inShowing = true,
            );
            debugPrint('$ad loaded.');
            interstitialAd = ad;
            interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            inShowing = false;
          },
        ),
      );
    }
  }
}
