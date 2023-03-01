import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/screens/onboarding/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObSpacePage extends StatelessWidget {
  const ObSpacePage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return OnboardingBody(
      backImageAssets: 'assets/images/ob_space.png',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Browse\nBetween Multi\nSocial Media\nin 🪐 Space',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppConfig().fsBannerSmall,
                ),
              ),
            ),
            SizedBox(height: 20.w),
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: PrimaryButtonWidget(
                    text: 'BACK',
                    async: false,
                    backgroundColor: const Color(0xff151515),
                    function: () => navigatorKey.currentState!.maybePop(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PrimaryButtonWidget(
                    text: 'NEXT',
                    async: false,
                    function: () =>
                        navigatorKey.currentState!.pushNamed('download'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
