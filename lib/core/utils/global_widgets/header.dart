import 'package:catchit/core/helper/disable_focus.dart';
import 'package:flutter/material.dart';

import 'keyboard_visibility.dart';
import 'remove_scroll_glow_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    disableFocus();

    return Material(
      color: Theme.of(context).backgroundColor,
      child: RemoveScrollGlowWidget(
        child: Column(
          children: [
            Expanded(child: child),
            const KeyboardVisibity(),
          ],
        ),
      ),
    );
  }
}
