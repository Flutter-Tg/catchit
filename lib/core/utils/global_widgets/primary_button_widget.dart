import 'package:catchit/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButtonWidget extends StatefulWidget {
  const PrimaryButtonWidget({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor = AppConfig.red,
    this.textColor = Colors.white,
    required this.text,
    required this.async,
    required this.function,
    this.icon,
  });
  final double? width;
  final double? height;
  final double? radius;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final IconData? icon;
  final bool async;
  final Function() function;

  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.async
          ? () async {
              setState(() => inProgress = true);
              await widget.function();
              setState(() => inProgress = false);
            }
          : widget.function,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 12.r),
        ),
        child: SizedBox(
          width: widget.width,
          height: widget.height ?? 45.w,
          child: Center(
            child: inProgress
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: (widget.height ?? 45.w) - 10.w,
                      maxWidth: (widget.height ?? 45.w) - 10.w,
                    ),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Padding(
                          padding: EdgeInsets.only(right: 10.r),
                          child: Icon(
                            widget.icon,
                            size: 26.sp,
                            color: widget.textColor,
                          ),
                        ),
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: AppConfig().fsTitleSmall,
                          color: widget.textColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
