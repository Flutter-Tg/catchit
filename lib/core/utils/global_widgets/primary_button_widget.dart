import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButtonWidget extends StatefulWidget {
  const PrimaryButtonWidget({
    super.key,
    this.width,
    this.height = 45,
    this.radius = 12,
    this.backgroundColor = ThemeConstants.green,
    this.textColor = Colors.white,
    required this.text,
    required this.async,
    required this.function,
    this.icon,
  });
  final double? width;
  final double height;
  final double radius;
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
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        ),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Center(
            child: inProgress
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: widget.height - 10,
                      maxWidth: widget.height - 10,
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
                          padding: const EdgeInsets.only(right: 10),
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
                          fontSize: ThemeConstants().fsTitleSmall,
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
