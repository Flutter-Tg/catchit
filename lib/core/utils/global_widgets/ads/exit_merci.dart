import 'package:catchit/core/services/ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ExitMerciAdWidget extends StatefulWidget {
  const ExitMerciAdWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<ExitMerciAdWidget> createState() => _ExitMerciAdWidgetState();
}

class _ExitMerciAdWidgetState extends State<ExitMerciAdWidget> {
  BannerAd? banner;
  @override
  void initState() {
    if (ExitMerciAdHelper.initialized) {
      banner = ExitMerciAdHelper.bannerAd;
    } else {
      banner = BannerAd(
        adUnitId: ExitMerciAdHelper.unitId,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            ExitMerciAdHelper.initialized = true;
            ExitMerciAdHelper.bannerAd = banner;
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
