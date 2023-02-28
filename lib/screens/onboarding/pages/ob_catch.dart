import 'package:flutter/material.dart';

import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';

class ObCatchPage extends StatelessWidget {
  const ObCatchPage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

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
              child: Image.asset(
                'assets/images/ob_catch.png',
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 180,
            left: 20,
            right: 20,
            child: ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Catch\nAnything you\nWant Quickly',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ThemeConstants().fsBannerSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
