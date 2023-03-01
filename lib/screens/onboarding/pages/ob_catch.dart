import 'package:flutter/material.dart';

import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObCatchPage extends StatelessWidget {
  const ObCatchPage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppConfig.black,
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
            bottom: 180.w,
            left: 20.w,
            right: 20.w,
            child: ShowUpFadeAnimation(
              delay: 4,
              child: Text(
                'Catch\nAnything you\nWant Quickly',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppConfig().fsBannerSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
