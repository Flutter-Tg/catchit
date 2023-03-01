import 'package:catchit/core/utils/animations/show_up_fade.dart';
import 'package:catchit/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObWelcomePage extends StatelessWidget {
  const ObWelcomePage({super.key, required this.navigatorKey});
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
                'assets/images/ob_welcome.png',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppConfig().fsBannerSmall,
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Image.asset('assets/logo/logo.png',
                      width: 110.w, height: 28.w),
                  SizedBox(height: 25.w),
                  Text(
                    'Take a few steps to know what you can do with us🤩',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppConfig().fsTitleSmall,
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
