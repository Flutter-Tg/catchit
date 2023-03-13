import 'package:catchit/core/services/ads/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainBannerWidget extends StatefulWidget {
  const MainBannerWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<MainBannerWidget> createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  NativeAd? nativeAd;
  bool isLoaded = false;

  @override
  void initState() {
    if (MainNativeAdHelper.initialized) {
      nativeAd = MainNativeAdHelper.nativeAd;
      setState(() => isLoaded = true);
    } else {
      nativeAd = NativeAd(
        adUnitId: MainNativeAdHelper.unitId,
        request: const AdRequest(),
        factoryId: 'mainNativeAd',
        listener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('Ad loaded.');
            MainNativeAdHelper.initialized = true;
            MainNativeAdHelper.nativeAd = nativeAd;
            setState(() => isLoaded = true);
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            debugPrint('Ad failed to load: $error');
          },
          // onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
          // onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
          // onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
        ),
      )..load();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.r),
        child: ColoredBox(
          color: const Color(0xff252525),
          child: SizedBox(
            width: 1.sw - 40.w,
            height: 440,
            child: AdWidget(ad: nativeAd!),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

// class MainBannerWidget extends StatefulWidget {
//   const MainBannerWidget({super.key, this.padding = EdgeInsets.zero});
//   final EdgeInsets padding;

//   @override
//   State<MainBannerWidget> createState() => _MainBannerWidgetState();
// }

// class _MainBannerWidgetState extends State<MainBannerWidget> {
//   BannerAd? banner;
//   @override
//   void initState() {
//     if (MainBannerHelper.initialized) {
//       banner = MainBannerHelper.bannerAd;
//     } else {
//       banner = BannerAd(
//         adUnitId: MainBannerHelper.unitId,
//         request: const AdRequest(),
//         size: AdSize.mediumRectangle,
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             debugPrint('$ad loaded.');
//             MainBannerHelper.initialized = true;
//             MainBannerHelper.bannerAd = banner;
//             setState(() {});
//           },
//           onAdFailedToLoad: (ad, err) {
//             debugPrint('BannerAd failed to load: $err');
//             ad.dispose();
//           },
//         ),
//       )..load();
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (banner != null) {
//       return Padding(
//         padding: widget.padding,
//         child: SizedBox(
//           width: banner!.size.width.toDouble(),
//           height: banner!.size.height.toDouble(),
//           child: AdWidget(ad: banner!),
//         ),
//       );
//     } else {
//       return const SizedBox();
//     }
//   }
// }
