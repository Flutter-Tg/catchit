import 'package:flutter/cupertino.dart';

class ShowScaleAnimation extends StatefulWidget {
  const ShowScaleAnimation({
    Key? key,
    required this.child,
    this.delay = 0,
    this.animationController,
    this.autoPlay = true,
  }) : super(key: key);
  final Widget child;
  final int delay;
  final AnimationController? animationController;
  final bool autoPlay;

  @override
  State<ShowScaleAnimation> createState() => _ShowScaleAnimationState();
}

class _ShowScaleAnimationState extends State<ShowScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    if (widget.animationController == null) {
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000));
    } else {
      controller = widget.animationController!;
    }
    scale = Tween(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    if (widget.autoPlay) {
      Future.delayed(Duration(milliseconds: (widget.delay * 100).round()), () {
        controller.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.scale(
        scale: scale.value,
        child: child as Widget,
      ),
      child: widget.child,
    );
  }
}
