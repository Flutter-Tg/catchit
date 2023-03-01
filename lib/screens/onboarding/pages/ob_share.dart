import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/screens/onboarding/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObSharePage extends ConsumerWidget {
  const ObSharePage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingBody(
      backImageAssets: 'assets/images/ob_share.png',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Share\nBetween your\nFriends',
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
                SizedBox(width: 20.w),
                Expanded(
                  child: PrimaryButtonWidget(
                    text: 'NEXT',
                    async: false,
                    function: () {
                      ref.read(routerProvider).goNamed('main');
                    },
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
