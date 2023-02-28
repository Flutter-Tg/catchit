import 'dart:io';
import 'package:catchit/core/helper/calculator.dart';
import 'package:catchit/core/params/download_param.dart';
import 'package:catchit/core/services/internet.dart';
import 'package:catchit/core/services/storage.dart';
import 'package:catchit/core/utils/global_widgets/modals/network_error.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/screens/detail/detail_controller.dart';
import 'package:catchit/core/utils/global_widgets/modals/success_download_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:catchit/core/helper/app_storage_path.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
    required this.param,
  });

  final DownloadBtnParam param;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool downloading = false;
  bool isFailed = false;
  bool isSuccess = false;
  String? networkError;
  int progress = 0;
  File file = File('');
  CancelToken cancelToken = CancelToken();

  Future<bool> donwnloadFile() async {
    Dio dio = Dio();
    if (await InternetService().checkConncetivity()) {
      try {
        await Permission.storage.request();
        String path = await AppStoragePath().getCashPath();
        String filePath = '$path/${widget.param.fileName}';
        final response = await dio.download(
          widget.param.fileUrl,
          filePath,
          cancelToken: cancelToken,
          onReceiveProgress: (received, total) {
            if (total == -1 && widget.param.fileSize != null && mounted) {
              final newProgress =
                  ((received / (widget.param.fileSize as int)) * 100).round();
              if (progress != newProgress && progress <= 99) {
                setState(() => progress = newProgress);
              }
            } else {
              if (mounted) {
                setState(() => progress = ((received / total) * 100).round());
              }
            }
          },
        );
        if (response.statusCode == 200) {
          file = File(filePath);
          networkError = null;
          return true;
        } else {
          networkError = null;
          return false;
        }
      } catch (e) {
        debugPrint('donwnloadFile : error = $e');
        networkError =
            'Unfortunately, You cannot download this item with your current network, Please use VPN or another WIFI Network';
        return false;
      }
    } else {
      networkErrorModal(context: context);
      return false;
    }
  }

  startDownload() async {
    // String donwloadPath =
    //     '${await AppStoragePath().getPath()}/${widget.param.fileName}';
    // if (await File(donwloadPath).exists()) {
    if (mounted) {
      setState(() {
        isFailed = false;
        progress = 0;
        downloading = true;
      });
    }
    bool isDonloaded = await donwnloadFile();
    if (isDonloaded) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          progress = 100;
          downloading = false;
          isSuccess = true;
        });
        String result = await DetailController()
            .createFile(param: widget.param, file: file);
        if (result != 'success') {
          Fluttertoast.showToast(msg: result);
        }
      }
      HapticFeedback.vibrate();
    } else {
      if (mounted) setState(() => isFailed = true);
    }
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "You already have this file, please check : $donwloadPath");
    // }
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.param.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.param.title as String,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ThemeConstants().fsTitleSmall,
                color: Colors.white,
              ),
            ),
          ),
        if (isSuccess)
          Row(
            children: [
              Expanded(
                child: PrimaryButtonWidget(
                  function: () async {
                    String result = await DetailController().createFile(
                      param: widget.param,
                      file: file,
                    );
                    if (result == 'success') {
                      HapticFeedback.vibrate();
                      successSaveModal(context: context);
                    } else {
                      Fluttertoast.showToast(msg: result);
                    }
                  },
                  backgroundColor: const Color(0x0F25A777),
                  textColor: const Color(0xff25A778),
                  async: true,
                  text: 'Saved',
                  icon: Icons.check_circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButtonWidget(
                  function: () async => await OpenFilex.open(file.path),
                  async: true,
                  backgroundColor: const Color(0xff376BF2),
                  text: 'Open',
                  icon: Icons.open_in_new,
                ),
              ),
              const SizedBox(width: 10),
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
          )
        else
          downloading
              ? InkWell(
                  onTap: () {
                    if (isFailed) startDownload();
                  },
                  child: DownloadingBox(
                    progress: progress,
                    isFailed: isFailed,
                    showProgress: widget.param.fileSize == null ? false : true,
                  ),
                )
              : PrimaryButtonWidget(
                  function: () => startDownload(),
                  async: false,
                  text:
                      'Download ${widget.param.fileSize != null ? Calculator().byte(widget.param.fileSize as int) : ""}',
                  icon: Icons.file_download_outlined,
                ),
        if (networkError != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              networkError!,
              style: TextStyle(
                  color: Colors.red, fontSize: ThemeConstants().fsTextSmall),
            ),
          )
      ],
    );
  }
}

class DownloadingBox extends StatelessWidget {
  const DownloadingBox({
    super.key,
    required this.progress,
    required this.isFailed,
    this.showProgress = true,
  });
  final int progress;
  final bool isFailed;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: showProgress
          ? ColoredBox(
              color: ThemeConstants.green.withOpacity(0.2),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 45,
                      width: (1.sw - 40) * progress / 100,
                      color: isFailed
                          ? const Color(0xFFFC564A)
                          : ThemeConstants.green,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isFailed)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.replay,
                              size: 26.sp,
                              color: Colors.white,
                            ),
                          ),
                        Text(
                          isFailed ? 'try again' : '$progress%',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ThemeConstants().fsTitleSmall,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: 45,
              color: isFailed ? const Color(0xFFFC564A) : ThemeConstants.green,
              child: isFailed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.replay,
                            size: 26.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'try again',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ThemeConstants().fsTitleSmall,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )),
    );
  }
}
