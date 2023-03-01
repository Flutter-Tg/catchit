import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.centerChild,
    this.leftChild,
    this.rightChild,
    this.width = double.infinity,
    this.height,
    this.padding = EdgeInsets.zero,
  });
  final Widget centerChild;
  final Widget? leftChild;
  final Widget? rightChild;
  final double width;
  final double? height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height ?? 60.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (leftChild != null)
              Positioned(
                left: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leftChild,
                ),
              ),
            if (rightChild != null)
              Positioned.fill(
                right: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: rightChild,
                ),
              ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: centerChild,
              ),
            )
          ],
        ),
      ),
    );
  }
}
