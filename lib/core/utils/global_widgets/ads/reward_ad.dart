// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class RewardAdWidget extends StatefulWidget {
//   const RewardAdWidget({
//     super.key,
//     required this.adUnitId,
//     required this.child,
//   });
//   final String adUnitId;
//   final Widget child;

//   @override
//   State<RewardAdWidget> createState() => RewardAdWidgetState();
// }

// class RewardAdWidgetState extends State<RewardAdWidget> {
//   RewardedAd? rewardedAd;

//   void loadRewardedAd() {
//     debugPrint('ads : riward start');
//     RewardedAd.load(
//       adUnitId: widget.adUnitId,
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//               setState(() {
//                 ad.dispose();
//                 rewardedAd = null;
//               });
//               loadRewardedAd();
//             },
//           );

//           setState(() {
//             rewardedAd = ad;
//           });
//         },
//         onAdFailedToLoad: (err) {
//           debugPrint('ads : riward error : ${err.message}');
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => loadRewardedAd(),
//       child: widget.child,
//     );
//   }
// }
