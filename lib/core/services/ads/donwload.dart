// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class DownloadIntersialAdHelper {
//   static bool inShowing = false;
//   static String get unitId {
//     if (kReleaseMode) {
//       if (Platform.isAndroid) {
//         return '';
//       } else if (Platform.isIOS) {
//         return '';
//       }
//     } else {
//       if (Platform.isAndroid) {
//         return 'ca-app-pub-3940256099942544/1033173712';
//       } else if (Platform.isIOS) {
//         return 'ca-app-pub-3940256099942544/4411468910';
//       }
//     }
//     return '';
//   }

//   Future showAd() async {
//     inShowing = true;
//     await RewardedAd.load(
//       adUnitId: unitId,
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (RewardedAd ad) async {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//               inShowing = false;
//             },
//             onAdDismissedFullScreenContent: (ad) {
//               inShowing = false;
//             },
//             onAdWillDismissFullScreenContent: (ad) {
//               inShowing = false;
//             },
//             onAdImpression: (ad) {
//               inShowing = false;
//             },
//           );
//           await ad.show(onUserEarnedReward:
//               (AdWithoutView ad, RewardItem rewardItem) async {
//             inShowing = false;
//           });
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           inShowing = false;
//         },
//       ),
//     );
//   }
// }
