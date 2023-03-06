// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/ads/open_app.dart';
import 'package:catchit/core/services/foregrounding_event.dart';
import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/core/services/update.dart';
import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
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
  // OpenAdAdHelper appOpenAdManager = OpenAdAdHelper();

  @override
  void initState() {
    //   appLifecycleReactor =
    //       AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    Future init() async {
      // if(BannerConfig.openApp) await appOpenAdManager.loadAd();
      bool haveUpdate = await UpdateService().checkNewVersion();
      if (haveUpdate) {
        ref.read(routerProvider).goNamed('update');
      } else {
        bool privacy = await PrivacyService().checkAcepted();
        await ref.read(historyProvider).getHistory();
        await Future.delayed(const Duration(seconds: 3));
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 3),
            ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Catch',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w700),
              ),
            ),
            ShowUpFadeAnimation(
              delay: 6,
              child: Text(
                'Anything You ',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w700),
              ),
            ),
            ShowUpFadeAnimation(
              delay: 8,
              child: Text(
                'Want Easily',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(flex: 2),
            ShowUpFadeAnimation(
              delay: 10,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: const CircularProgressIndicator(
                      color: AppConfig.lightGray),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
