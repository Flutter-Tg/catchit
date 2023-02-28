import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/screens/onboarding/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class ObDownloadPage extends StatelessWidget {
  const ObDownloadPage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return OnboardingBody(
      backImageAssets: 'assets/images/ob_download.png',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Access\nTo Download\nHigh-Quality\nMedia & Audio',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ThemeConstants().fsBannerSmall,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 100,
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
                        navigatorKey.currentState!.pushNamed('share'),
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
