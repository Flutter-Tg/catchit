import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/network_imag_fade_widget.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.file});
  final FileEntity file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await OpenFilex.open(file.file);
      },
      child: file.thumb != null
          ? NetworkImageFadeWidget(
              width: double.infinity,
              imageUrl: file.thumb,
              radius: 8.r,
              fit: BoxFit.cover,
            )
          : ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: ColoredBox(
                color: AppConfig.lightGray,
                child: SizedBox(
                  width: 100.w,
                  height: double.infinity,
                  child: Image.asset('assets/images/no_image.png'),
                ),
              ),
            ),
    );
  }
}


            // const SizedBox(height: 7),
            // Text(
            //   detail.caption != null
            //       ? detail.caption!.title != null
            //           ? detail.caption!.title.toString().trim()
            //           : detail.caption!.description.toString().trim()
            //       : detail.title.trim(),
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 2,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: AppConfig().fsSmall,
            //     fontWeight: FontWeight.w400,
            //     height: 1.2,
            //   ),
            // ),
            // SizedBox(height: 9.w),
            // Image.asset(
            //   'assets/icons/${detail.platform}.png',
            //   width: 18.w,
            //   height: 18.w,
            // ),