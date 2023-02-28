// import 'package:catchit/core/services/reviwe.dart';
// import 'package:catchit/core/utils/consts/theme_constants.dart';
// import 'package:flutter/material.dart';

// class ReviewBanner extends StatefulWidget {
//   const ReviewBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ReviewBanner> createState() => _ReviewBannerState();
// }

// class _ReviewBannerState extends State<ReviewBanner> {
//   // var startAppSdk = StartAppSdk();
//   // StartAppRewardedVideoAd? rewardedVideoAd;

//   @override
//   void initState() {
//     super.initState();
//     // startAppSdk.setTestAdsEnabled(kReleaseMode ? false : true);
//   }

//   // Future loadRewardedVideoAd() async {
//   //   await startAppSdk.loadRewardedVideoAd(
//   //     onAdNotDisplayed: () {
//   //       setState(() {
//   //         rewardedVideoAd?.dispose();
//   //         rewardedVideoAd = null;
//   //       });
//   //     },
//   //     onAdHidden: () {
//   //       setState(() {
//   //         rewardedVideoAd?.dispose();
//   //         rewardedVideoAd = null;
//   //       });
//   //     },
//   //   ).then((rewardedVideoAd) {
//   //     setState(() {
//   //       this.rewardedVideoAd = rewardedVideoAd;
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         ReviewService().showRating();
//         // await loadRewardedVideoAd();
//         // if (rewardedVideoAd != null) {
//         //   rewardedVideoAd!.show().onError((error, stackTrace) {
//         //     debugPrint("Error showing Rewarded Video ad: $error");
//         //     return false;
//         //   });
//         // }
//       },
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           color: Color(0xff1F1F1F),
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Row(
//             children: [
//               Image.asset('assets/images/rating.png', height: 44),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(
//                     'Do you Love Catchit?',
//                     style: TextStyle(
//                       fontSize: ThemeConstants().fsTitleSmall,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               DecoratedBox(
//                 decoration: const BoxDecoration(
//                   color: Color(0xff483621),
//                   borderRadius: BorderRadius.all(Radius.circular(25)),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                   child: Text(
//                     'Submit Review',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: ThemeConstants().fsSmall,
//                       color: const Color(0xffFFCB13),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class DonateBanner extends StatefulWidget {
// //   const DonateBanner({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   State<DonateBanner> createState() => _DonateBannerState();
// // }

// // class _DonateBannerState extends State<DonateBanner> {
// //   var startAppSdk = StartAppSdk();

// //   StartAppInterstitialAd? interstitialAd;

// //   @override
// //   void initState() {
// //     super.initState();
// //     startAppSdk.setTestAdsEnabled(kReleaseMode ? false : true);
// //     loadInterstitialAd();
// //   }

// //   void loadInterstitialAd() {
// //     startAppSdk.loadInterstitialAd().then((interstitialAd) {
// //       setState(() {
// //         this.interstitialAd = interstitialAd;
// //       });
// //     }).onError<StartAppException>((ex, stackTrace) {
// //       debugPrint("Error loading Interstitial ad: ${ex.message}");
// //     }).onError((error, stackTrace) {
// //       debugPrint("Error loading Interstitial ad: $error");
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: () {
// //         if (interstitialAd != null) {
// //           interstitialAd!.show().then((shown) {
// //             if (shown) {
// //               setState(() {
// //                 interstitialAd = null;
// //                 loadInterstitialAd();
// //               });
// //             }
// //             return null;
// //           }).onError((error, stackTrace) {
// //             debugPrint("Error showing Interstitial ad: $error");
// //           });
// //         }
// //       },
// //       child: SizedBox(
// //         width: double.infinity,
// //         height: 150,
// //         child: Stack(
// //           alignment: Alignment.centerLeft,
// //           children: [
// //             const DecoratedBox(
// //               decoration: BoxDecoration(
// //                 color: Color(0xff2E4AAF),
// //                 borderRadius: BorderRadius.all(Radius.circular(25)),
// //               ),
// //               child: SizedBox(
// //                 height: 125,
// //                 width: double.infinity,
// //               ),
// //             ),
// //             Positioned(
// //               right: 30,
// //               child: Image.asset('assets/images/donate_text.png', height: 108),
// //             ),
// //             Image.asset('assets/images/donate.png')
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

