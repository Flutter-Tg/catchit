import 'package:catchit/core/services/ads/exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ExitBannerWidget extends StatefulWidget {
  const ExitBannerWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<ExitBannerWidget> createState() => _ExitBannerWidgetState();
}

class _ExitBannerWidgetState extends State<ExitBannerWidget> {
  NativeAd? nativeAd;
  bool isLoaded = false;

  @override
  void initState() {
    if (ExitNativeAdHelper.initialized) {
      nativeAd = ExitNativeAdHelper.nativeAd;
      setState(() => isLoaded = true);
    } else {
      nativeAd = NativeAd(
        adUnitId: ExitNativeAdHelper.unitId,
        request: const AdRequest(),
        factoryId: 'mainNativeAd',
        listener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            debugPrint('Ad loaded.');
            ExitNativeAdHelper.initialized = true;
            ExitNativeAdHelper.nativeAd = nativeAd;
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
            height: 440.w,
            child: AdWidget(ad: nativeAd!),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}


// class ExitBannerWidget extends StatefulWidget {
//   const ExitBannerWidget({super.key, this.padding = EdgeInsets.zero});
//   final EdgeInsets padding;

//   @override
//   State<ExitBannerWidget> createState() => _ExitBannerWidgetState();
// }

// class _ExitBannerWidgetState extends State<ExitBannerWidget> {
//   BannerAd? banner;
//   @override
//   void initState() {
//     if (ExitBannerHelper.initialized) {
//       banner = ExitBannerHelper.bannerAd;
//     } else {
//       banner = BannerAd(
//         adUnitId: ExitBannerHelper.unitId,
//         request: const AdRequest(),
//         size: AdSize.mediumRectangle,
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             debugPrint('$ad loaded.');
//             ExitBannerHelper.initialized = true;
//             ExitBannerHelper.bannerAd = banner;
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
