// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/ads/open_app.dart';
import 'package:catchit/core/services/permission.dart';
import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/core/services/update.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/future/config/repository.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:catchit/screens/splash/splash_controller.dart';
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
  OpenAdAdHelper appOpenAdManager = OpenAdAdHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    Future init() async {
      await ConfigRepository().fetchConfig();
      if (BannerConfig.openApp) await appOpenAdManager.loadAd();
      bool haveUpdate = await UpdateService().checkNewVersion();
      if (haveUpdate) {
        await SplashController().checkBanner();
        ref.read(routerProvider).goNamed('update');
      } else {
        bool privacy = await PrivacyService().checkAcepted();
        await ref.read(historyProvider).getHistory();
        await SplashController().checkBanner();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/logo/logo.png", width: 220.w),
          SizedBox(height: 70.w),
          SizedBox(
            width: 30.w,
            height: 30.w,
            child: const CircularProgressIndicator(color: AppConfig.lightGray),
          ),
        ],
      ),
    );
  }
}
