import 'package:flutter/material.dart';

class ScrollCanBody extends StatelessWidget {
  const ScrollCanBody({
    super.key,
    this.appbar = const SizedBox(),
    required this.body,
    this.bottomBar = const SizedBox(),
  });
  final Widget appbar;
  final Widget body;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appbar,
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: body,
              )
            ],
          ),
        ),
        bottomBar,
      ],
    );
  }
}
