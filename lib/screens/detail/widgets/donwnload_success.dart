import 'dart:io';
import 'package:catchit/core/helper/error_msg.dart';
import 'package:catchit/core/helper/save_file_in_storage.dart';
import 'package:catchit/core/params/download_param.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:catchit/core/utils/global_widgets/modals/success_download_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

class DownlodaSuccess extends ConsumerWidget {
  const DownlodaSuccess({
    super.key,
    required this.param,
    required this.file,
  });

  final DownloadBtnParam param;
  final File file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButtonWidget(
            function: () async {
              // String? result =
              //     await saveFileInStorage(param: param, file: file);
              // if (result == fileExict) {
              //   // Fluttertoast.showToast(msg: fileExict);
              //   Fluttertoast.showToast(msg: "Save done");
              // } else if (result == null) {
              //   Fluttertoast.showToast(msg: "can't saved, try again");
              // } else {
              //   ref.read(historyProvider).add(
              //         FileEntity(
              //           platform: param.platform,
              //           format: param.isAudio
              //               ? 'audio'
              //               : param.isVideo
              //                   ? 'video'
              //                   : 'image',
              //           link: param.fileUrl,
              //           file: result,
              //           title: param.fileName,
              //           thumb: param.thump,
              //         ),
              //       );
              //   HapticFeedback.vibrate();
              //   if (context.mounted) successSaveModal(context: context);
              // }
            },
            backgroundColor: const Color(0x0F25A777),
            textColor: const Color(0xff25A778),
            async: true,
            text: 'Saved',
            icon: Icons.check_circle,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: PrimaryButtonWidget(
            function: () async => await OpenFilex.open(file.path),
            async: true,
            backgroundColor: const Color(0xff376BF2),
            text: 'Open',
            icon: Icons.open_in_new,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: PrimaryButtonWidget(
            function: () {
              final box = context.findRenderObject() as RenderBox?;
              Share.shareXFiles([XFile(file.path)],
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size);
            },
            async: true,
            backgroundColor: const Color(0xffBB2F59),
            text: 'Share',
            icon: Icons.share_outlined,
          ),
        ),
      ],
    );
  }
}
