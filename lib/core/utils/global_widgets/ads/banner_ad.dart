import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:startapp_sdk/startapp.dart';

// class BannerAdWidget extends StatefulWidget {
//   const BannerAdWidget({
//     super.key,
//     this.emptyHight = 20,
//     required this.padding,
//   });
//   final double emptyHight;
//   final EdgeInsets padding;

//   @override
//   State<BannerAdWidget> createState() => BannerAdWidgetState();
// }

// class BannerAdWidgetState extends State<BannerAdWidget> {
//   var startAppSdk = StartAppSdk();
//   StartAppBannerAd? bannerAd;

//   @override
//   void initState() {
//     super.initState();
//     startAppSdk.setTestAdsEnabled(kDebugMode ? true : false);
//     // startAppSdk.setTestAdsEnabled(false);
//     startAppSdk
//         .loadBannerAd(
//       StartAppBannerType.BANNER,
//     )
//         .then((banner) {
//       setState(() {
//         bannerAd = banner;
//       });
//     }).onError<StartAppException>((ex, stackTrace) {
//       debugPrint("ads : Error loading Banner ad: ${ex.message}");
//     }).onError((error, stackTrace) {
//       debugPrint("ads : Error loading Banner ad: $error");
//     });
//   }

//   @override
//   void dispose() {
//     bannerAd?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (bannerAd != null) {
//       return Padding(
//         padding: widget.padding,
//         child: SizedBox(
//             width: bannerAd!.width,
//             height: bannerAd!.height,
//             child: StartAppBanner(bannerAd!)),
//       );
//     } else {
//       return SizedBox(height: widget.emptyHight);
//     }
//   }
// }


// import 'package:catchit/core/utils/consts/theme_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

// class BannerAdWidget extends StatefulWidget {
//   const BannerAdWidget({
//     super.key,
//     this.emptyHight = 20,
//     required this.padding,
//     required this.placement,
//   });
//   final double emptyHight;
//   final EdgeInsets padding;
//   final String placement;

//   @override
//   State<BannerAdWidget> createState() => BannerAdWidgetState();
// }

// class BannerAdWidgetState extends State<BannerAdWidget> {
//   AppodealBanner? bannerAd;

//   showAd() async {
//     debugPrint('ads : start');
//     var canShow = await Appodeal.show(AppodealAdType.Banner, widget.placement);
//     debugPrint('ads : $canShow');
//     if (canShow) {
//       setState(() {
//         bannerAd = AppodealBanner(
//             adSize: AppodealBannerSize.BANNER, placement: widget.placement);
//       });
//       Appodeal.setBannerCallbacks(
//         onBannerLoaded: (isPrecache) =>
//             debugPrint('ads : banner = isPrecache $isPrecache'),
//         onBannerFailedToLoad: () => debugPrint('ads : banner = Failed To Load'),
//         onBannerShown: () => debugPrint('ads : banner = Shown'),
//         onBannerShowFailed: () =>
//             debugPrint('ads : banner = onBannerShowFailed'),
//         onBannerClicked: () => debugPrint('ads : banner = Clicked'),
//         onBannerExpired: () => debugPrint('ads : banner = Expired'),
//       );
//     }
//   }

//   @override
//   void initState() {
//     showAd();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (bannerAd != null) {
//       return Padding(
//           padding: widget.padding,
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               color: ThemeConstants.blackGray,
//               border: Border.all(width: 1, color: ThemeConstants.gray),
//             ),
//             child: bannerAd,
//           ));
//     } else {
//       return SizedBox(height: widget.emptyHight);
//     }
//   }
// }

// import 'package:catchit/core/utils/consts/theme_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class BannerAdWidget extends StatefulWidget {
//   const BannerAdWidget({
//     super.key,
//     this.emptyHight = 20,
//     required this.padding,
//     required this.adUnitId,
//   });
//   final double emptyHight;
//   final EdgeInsets padding;
//   final String adUnitId;

//   @override
//   State<BannerAdWidget> createState() => BannerAdWidgetState();
// }

// class BannerAdWidgetState extends State<BannerAdWidget> {
//   BannerAd? bannerAd;

//   @override
//   void initState() {
//     debugPrint('ads : start');
//     //! ads
//     BannerAd(
//       adUnitId: widget.adUnitId,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           setState(() {
//             bannerAd = ad as BannerAd;
//           });
//         },
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('ads : banner error : ${err.message}');
//           ad.dispose();
//         },
//       ),
//     ).load();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     bannerAd?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (bannerAd != null) {
//       return Padding(
//           padding: widget.padding,
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               color: ThemeConstants.blackGray,
//               border: Border.all(width: 1, color: ThemeConstants.gray),
//             ),
//             child: SizedBox(
//               width: bannerAd!.size.width.toDouble(),
//               height: bannerAd!.size.height.toDouble(),
//               child: AdWidget(ad: bannerAd!),
//             ),
//           ));
//     } else {
//       return SizedBox(height: widget.emptyHight);
//     }
//   }
// }
