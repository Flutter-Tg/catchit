import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';

class ShowDelay extends StatefulWidget {
  const ShowDelay({
    super.key,
    this.duration = const Duration(seconds: 1),
    required this.child,
  });
  final Duration duration;
  final Widget child;

  @override
  State<ShowDelay> createState() => _ShowDelayState();
}

class _ShowDelayState extends State<ShowDelay> {
  bool show = false;

  @override
  void initState() {
    Future.delayed(widget.duration, () {
      if (mounted) setState(() => show = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return widget.child;
    } else {
      return const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: ThemeConstants.gray,
          ),
        ),
      );
    }
  }
}
