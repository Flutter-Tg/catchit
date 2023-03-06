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
      child: Stack(
        children: [
          file.thumb != null
              ? NetworkImageFadeWidget(
                  width: double.infinity,
                  imageUrl: file.thumb,
                  radius: 8.r,
                  fit: BoxFit.cover,
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppConfig.lightGray,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/no_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
          Positioned(
            top: 10.w,
            left: 10.w,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 50.w,
                height: 50.w,
                child: Center(
                  child: Icon(
                    Icons.picture_as_pdf,
                  ),
                ),
              ),
            ),
          )
        ],
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