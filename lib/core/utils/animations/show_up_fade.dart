import 'package:flutter/cupertino.dart';

class ShowUpFadeAnimation extends StatefulWidget {
  const ShowUpFadeAnimation({
    Key? key,
    required this.child,
    this.delay = 0,
    this.durationMili = 1000,
    this.controller,
  }) : super(key: key);
  final Widget child;
  final int delay;
  final int durationMili;
  final AnimationController? controller;

  @override
  State<ShowUpFadeAnimation> createState() => _ShowUpFadeAnimationState();
}

class _ShowUpFadeAnimationState extends State<ShowUpFadeAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> translateY;

  @override
  void initState() {
    if (widget.controller == null) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: widget.durationMili));
    } else {
      controller = widget.controller!;
    }
    opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    translateY = Tween(begin: 40.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    if (widget.controller == null) {
      Future.delayed(Duration(milliseconds: (widget.delay * 100).round()), () {
        controller.forward();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => FadeTransition(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(0, translateY.value),
          child: child as Widget,
        ),
      ),
      child: widget.child,
    );
  }
}
