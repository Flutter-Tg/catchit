import 'package:catchit/core/services/ads/exit.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ExitBannerWidget extends StatefulWidget {
  const ExitBannerWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<ExitBannerWidget> createState() => _ExitBannerWidgetState();
}

class _ExitBannerWidgetState extends State<ExitBannerWidget> {
  BannerAd? banner;
  @override
  void initState() {
    if (ExitBannerHelper.initialized) {
      banner = ExitBannerHelper.bannerAd;
    } else {
      banner = BannerAd(
        adUnitId: ExitBannerHelper.unitId,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            ExitBannerHelper.initialized = true;
            ExitBannerHelper.bannerAd = banner;
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
