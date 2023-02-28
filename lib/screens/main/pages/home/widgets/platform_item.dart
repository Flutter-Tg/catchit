import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';

class PlatformItem extends StatelessWidget {
  const PlatformItem({
    Key? key,
    required this.asset,
    required this.title,
  }) : super(key: key);
  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(asset, width: 20, height: 20),
        const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: ThemeConstants().fsSmall,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
