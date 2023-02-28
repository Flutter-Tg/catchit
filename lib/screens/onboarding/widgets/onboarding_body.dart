import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/animations/show_up_fade.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody(
      {super.key, required this.backImageAssets, required this.child});
  final String backImageAssets;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ThemeConstants.black,
      child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: ShowUpFadeAnimation(
              delay: 2,
              child: Image.asset(backImageAssets, width: double.infinity),
            ),
          ),
          Positioned(
            bottom: 0.35.sw,
            child: SizedBox(
              width: 1.sw,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
