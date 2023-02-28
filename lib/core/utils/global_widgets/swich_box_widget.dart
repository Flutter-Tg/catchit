import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';

class SwichBoxWidget extends StatefulWidget {
  const SwichBoxWidget(
      {super.key, required this.initValue, required this.onChanged});
  final bool initValue;
  final ValueChanged<bool> onChanged;

  @override
  State<SwichBoxWidget> createState() => _SwichBoxWidgetState();
}

class _SwichBoxWidgetState extends State<SwichBoxWidget> {
  bool active = false;
  @override
  void initState() {
    active = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => active = !active);
        widget.onChanged(active);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: active ? const Color(0xff2281F1) : ThemeConstants.gray,
        ),
        padding: const EdgeInsets.all(2),
        width: 50,
        height: 30,
        alignment: active ? Alignment.centerRight : Alignment.centerLeft,
        child: const DecoratedBox(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: SizedBox(width: 27, height: 27),
        ),
      ),
    );
  }
}
