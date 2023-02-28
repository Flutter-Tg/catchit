import 'package:catchit/core/helper/disable_focus.dart';
import 'package:flutter/material.dart';

import 'keyboard_visibility.dart';
import 'remove_scroll_glow_widget.dart';

class ScreenHead extends StatelessWidget {
  const ScreenHead({super.key, required this.child, this.backColor});
  final Widget child;
  final Color? backColor;

  @override
  Widget build(BuildContext context) {
    disableFocus();
    return Material(
      color: backColor ?? Theme.of(context).colorScheme.background,
      child: RemoveScrollGlowWidget(
        child: Column(
          children: [
            Expanded(
              child: child,
            ),
            const KeyboardVisibity(),
          ],
        ),
      ),
    );
  }
}
