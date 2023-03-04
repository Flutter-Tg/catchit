import 'package:catchit/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformItem extends StatelessWidget {
  const PlatformItem({
    Key? key,
    // required this.asset,
    required this.title,
  }) : super(key: key);
  // final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(asset, width: 20.w, height: 20.w),
        // SizedBox(width: 5.w),
        Text(
          title,
          style: TextStyle(
            fontSize: AppConfig().fsSmall,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class PlatformVerticalItem extends StatelessWidget {
  const PlatformVerticalItem({
    Key? key,
    // required this.asset,
    required this.title,
    required this.titleColor,
    required this.sub,
  }) : super(key: key);
  // final String asset;
  final String title;
  final Color titleColor;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: SizedBox(
        width: 100.w,
        height: 50.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppConfig().fsSmall,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
            Text(
              sub,
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
