import 'package:catchit/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDelay extends StatefulWidget {
  const ShowDelay({super.key, required this.child});
  final Widget child;

  @override
  State<ShowDelay> createState() => _ShowDelayState();
}

class _ShowDelayState extends State<ShowDelay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool loading = true;
  bool show = false;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
    play();
  }

  play() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => show = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) await controller.forward();
    if (mounted) setState(() => loading = false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (show) widget.child,
        if (loading)
          FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(
                CurvedAnimation(parent: controller, curve: Curves.ease)),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: const CircularProgressIndicator(
                    color: AppConfig.gray,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
