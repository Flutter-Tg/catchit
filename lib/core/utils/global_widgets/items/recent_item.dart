import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/network_imag_fade_widget.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({super.key, required this.detail});
  final DetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (detail.thumb != null)
            NetworkImageFadeWidget(
              height: 100,
              width: double.infinity,
              imageUrl: detail.thumb,
              radius: 8,
              fit: BoxFit.cover,
            )
          else
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: ColoredBox(
                color: ThemeConstants.lightGray,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/no_image.png'),
                ),
              ),
            ),
          const SizedBox(height: 7),
          Text(
            detail.caption != null
                ? detail.caption!.title != null
                    ? detail.caption!.title.toString().trim()
                    : detail.caption!.description.toString().trim()
                : detail.title.trim(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: ThemeConstants().fsSmall,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 9),
          Image.asset(
            'assets/icons/${detail.platform}.png',
            width: 18,
            height: 18,
          ),
        ],
      ),
    );
  }
}
