import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObWelcomePage extends StatelessWidget {
  const ObWelcomePage({super.key, required this.navigatorKey});
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
                'assets/images/ob_welcome.png',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: ThemeConstants().fsBannerSmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset('assets/logo/logo.png', width: 110, height: 28),
                  const SizedBox(height: 25),
                  Text(
                    'Take a few steps to know what you can do with us🤩',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ThemeConstants().fsTitleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
