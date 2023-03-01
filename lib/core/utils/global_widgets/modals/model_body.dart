import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalBody extends StatelessWidget {
  const ModalBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShowScaleAnimation(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppConfig.black,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: child,
        ),
      ),
    );
  }
}
