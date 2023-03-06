import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdService {
//   static String get rewardAdUnitId1 {
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
//   Future showRewardAd(String adUnitId, Future Function() ernFunction) async {
//     bool result = false;
//     bool impression = false;
//     await RewardedAd.load(
//       adUnitId: adUnitId,
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (RewardedAd ad) async {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//               result = true;
//             },
//             onAdDismissedFullScreenContent: (ad) {
//               result = true;
//             },
//             onAdWillDismissFullScreenContent: (ad) {
//               result = true;
//             },
//             onAdImpression: (ad) {
//               impression = true;
//             },
//           );
//           await ad.show(onUserEarnedReward:
//               (AdWithoutView ad, RewardItem rewardItem) async {
//             impression = true;
//             result = true;
//           });
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           if (error.toString().toLowerCase().contains('no ad')) {
//             Fluttertoast.showToast(msg: 'No ad to show. Try again later...');
//           }
//           result = true;
//         },
//       ),
//     );
//     await Future.doWhile(() async {
//       await Future.delayed(const Duration(seconds: 1));
//       if (result == true) {
//         if (impression) {
//           await ernFunction();
//           return false;
//         } else {
//           return false;
//         }
//       } else {
//         return true;
//       }
//     });
//   }
//   // Future<bool> checkClick(
//   //     {required String name,
//   //     required int maxClick,
//   //     required bool showToast}) async {
//   //   final hive = Hive.box('Ads');
//   //   final click = await hive.get(name);
//   //   if (click == null) {
//   //     await hive.put(name, {'count': 1, 'time': DateTime.now()});
//   //     return true;
//   //   } else {
//   //     Duration timePaset = DateTime.now().difference(click['time']);
//   //     if (timePaset.inMinutes < 2) {
//   //       if (click['count'] <= maxClick) {
//   //         await hive
//   //             .put(name, {'count': click['count'] + 1, 'time': DateTime.now()});
//   //         return true;
//   //       } else {
//   //         if (showToast) {
//   //           int min = (5 - timePaset.inMinutes).abs();
//   //           Fluttertoast.showToast(msg: 'You can try again in $min minutes');
//   //         }
//   //         return false;
//   //       }
//   //     } else {
//   //       hive.put(name, {'count': 1, 'time': DateTime.now()});
//   //       return true;
//   //     }
//   //   }
//   // }
// }

class OpenAddAdHelper {
  // static BannerAd? bannerAd;
  // static bool initialized = false;
  // static String get appOpenAdUnitId {
  //   if (kReleaseMode) {
  //     if (Platform.isAndroid) {
  //       return '';
  //     } else {
  //       return '';
  //     }
  //   } else {
  //     if (Platform.isAndroid) {
  //       return 'ca-app-pub-3940256099942544/3419835294';
  //     } else {
  //       return 'ca-app-pub-3940256099942544/5662855259';
  //     }
  //   }
  // }
}

class MerciAdHelper {
  static BannerAd? bannerAd;
  static bool initialized = false;
  static String get unitId {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return '';
      } else {
        return '';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
  }
}

class ExitMerciAdHelper {
  static BannerAd? bannerAd;
  static bool initialized = false;
  static String get unitId {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return '';
      } else {
        return '';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }
  }
}

class DownloadIntersialAdHelper {
  static bool inShowing = false;
  static String get unitId {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return '';
      } else if (Platform.isIOS) {
        return '';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    }
    return '';
  }

  Future showAd() async {
    inShowing = true;
    await RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) async {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              inShowing = false;
            },
            onAdDismissedFullScreenContent: (ad) {
              inShowing = false;
            },
            onAdWillDismissFullScreenContent: (ad) {
              inShowing = false;
            },
            onAdImpression: (ad) {
              inShowing = false;
            },
          );
          await ad.show(onUserEarnedReward:
              (AdWithoutView ad, RewardItem rewardItem) async {
            inShowing = false;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          inShowing = false;
        },
      ),
    );
  }
}

// class DownloadIntersialAdHelper {
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
//   Future showIntersitialAd() async {
//     bool result = false;
//     await InterstitialAd.load(
//         adUnitId: unitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) async {
//             ad.fullScreenContentCallback = FullScreenContentCallback(
//               onAdDismissedFullScreenContent: (InterstitialAd ad) {
//                 debugPrint('$ad onAdDismissedFullScreenContent.');
//                 ad.dispose();
//                 result = true;
//               },
//               onAdFailedToShowFullScreenContent:
//                   (InterstitialAd ad, AdError error) {
//                 debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//                 ad.dispose();
//                 result = true;
//               },
//               onAdImpression: (InterstitialAd ad) {
//                 debugPrint('$ad impression occurred.');
//                 result = true;
//               },
//             );
//             await Future.delayed(const Duration(seconds: 2));
//             await ad.show();
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('ads : $error');
//             result = true;
//           },
//         ));
//     await Future.doWhile(() async {
//       await Future.delayed(const Duration(seconds: 1));
//       if (result == true) {
//         return false;
//       } else {
//         return true;
//       }
//     });
//   }
// }
