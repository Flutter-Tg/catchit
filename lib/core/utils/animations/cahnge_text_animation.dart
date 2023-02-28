import 'package:flutter/material.dart';

class ChangeTextAnimation extends StatefulWidget {
  const ChangeTextAnimation(
      {super.key,
      required this.text,
      required this.textStyle,
      required this.duration});
  final String text;
  final TextStyle textStyle;
  final Duration duration;

  @override
  State<ChangeTextAnimation> createState() => ChangeTextAnimationState();
}

class ChangeTextAnimationState extends State<ChangeTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  String? text;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    opacity = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    super.initState();
  }

  changeText(String newText) async {
    await controller.forward();
    setState(() => text = newText);
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Text(text ?? widget.text, style: widget.textStyle),
      builder: (context, child) => FadeTransition(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
