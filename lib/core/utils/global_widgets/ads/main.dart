import 'package:catchit/core/services/ads/main.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainBannerWidget extends StatefulWidget {
  const MainBannerWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<MainBannerWidget> createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  BannerAd? banner;
  @override
  void initState() {
    if (MainBannerHelper.initialized) {
      banner = MainBannerHelper.bannerAd;
    } else {
      banner = BannerAd(
        adUnitId: MainBannerHelper.unitId,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            MainBannerHelper.initialized = true;
            MainBannerHelper.bannerAd = banner;
            setState(() {});
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            ad.dispose();
          },
        ),
      )..load();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (banner != null) {
      return Padding(
        padding: widget.padding,
        child: SizedBox(
          width: banner!.size.width.toDouble(),
          height: banner!.size.height.toDouble(),
          child: AdWidget(ad: banner!),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
