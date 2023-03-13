import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/services/ads/open_app.dart';

class SplashController {
  Future checkBanner() async {
    if (BannerConfig.openApp) {
      await Future.doWhile(
        () async {
          await Future.delayed(const Duration(seconds: 1));
          if (OpenAdAdHelper.showed) {
            return OpenAdAdHelper.isShowingAd;
          } else {
            if (OpenAdAdHelper.failed >= 2) {
              return OpenAdAdHelper.isShowingAd;
            } else if (OpenAdAdHelper.isShowingAd) {
              return true;
            } else {
              OpenAdAdHelper().loadAd();
              return true;
            }
          }
        },
      );
    }
  }
}
