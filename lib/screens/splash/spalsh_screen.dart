// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/internet.dart';
import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'splash_controller.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FlutterNativeSplash.remove();

    Future init() async {
      if (await InternetService().checkConncetivity()) {}
      bool privacy = await PrivacyService().checkAcepted();
      await ref.read(historyProvider).getHistory();
      await Future.delayed(const Duration(seconds: 3));
      if (privacy) {
        ref.read(routerProvider).goNamed('main');
      } else {
        ref.read(routerProvider).goNamed('privacy');
      }
    }

    SplashController().checkVersion(context);
    init();
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const ShowUpFadeAnimation(
              delay: 10,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: ThemeConstants.lightGray,
                  ),
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
