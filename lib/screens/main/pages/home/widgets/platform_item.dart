import 'package:catchit/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformItem extends StatelessWidget {
  const PlatformItem({
    Key? key,
    required this.asset,
    required this.title,
  }) : super(key: key);
  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(asset, width: 20.w, height: 20.w),
        SizedBox(width: 5.w),
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
