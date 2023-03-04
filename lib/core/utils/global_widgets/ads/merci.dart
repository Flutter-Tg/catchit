import 'package:catchit/core/services/ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MerciAdWidget extends StatefulWidget {
  const MerciAdWidget({super.key, this.padding = EdgeInsets.zero});
  final EdgeInsets padding;

  @override
  State<MerciAdWidget> createState() => _MerciAdWidgetState();
}

class _MerciAdWidgetState extends State<MerciAdWidget> {
  BannerAd? banner;
  @override
  void initState() {
    if (MerciAdHelper.initialized) {
      banner = MerciAdHelper.bannerAd;
    } else {
      banner = BannerAd(
        adUnitId: AdService.bannerAdUnitId1,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            MerciAdHelper.initialized = true;
            MerciAdHelper.bannerAd = banner;
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
