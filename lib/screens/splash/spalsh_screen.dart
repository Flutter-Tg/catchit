// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/ads/open_app.dart';
import 'package:catchit/core/services/permission.dart';
import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/core/services/update.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/future/config/repository.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // late AppLifecycleReactor appLifecycleReactor;
  OpenAdAdHelper appOpenAdManager = OpenAdAdHelper();

  @override
  void initState() {
    //   appLifecycleReactor =
    //       AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
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
                appOpenAdManager.loadAd();
                return true;
              }
            }
          },
        );
      }
    }

    Future init() async {
      if (BannerConfig.openApp) await appOpenAdManager.loadAd();
      await ConfigRepository().fetchConfig();
      bool haveUpdate = await UpdateService().checkNewVersion();
      // bool haveUpdate = false;
      if (haveUpdate) {
        await checkBanner();
        ref.read(routerProvider).goNamed('update');
      } else {
        bool privacy = await PrivacyService().checkAcepted();
        await ref.read(historyProvider).getHistory();
        await checkBanner();
        await storagePermission();
        if (privacy) {
          ref.read(routerProvider).goNamed('main');
        } else {
          ref.read(routerProvider).goNamed('privacy');
        }
      }
    }

    init();
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: SizedBox(
          width: 30.w,
          height: 30.w,
          child: const CircularProgressIndicator(color: AppConfig.lightGray),
        ),
      ),
    );
  }
}
