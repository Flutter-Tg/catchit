import 'package:flutter/material.dart';

class KeyboardVisibity extends StatefulWidget {
  const KeyboardVisibity({super.key});

  @override
  State<KeyboardVisibity> createState() => _KeyboardVisibityState();
}

class _KeyboardVisibityState extends State<KeyboardVisibity>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isKeyboardVisible = false;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: EdgeInsets.fromWindowPadding(
              WidgetsBinding.instance.window.viewInsets,
              WidgetsBinding.instance.window.devicePixelRatio)
          .bottom,
    );
  }
}
