import 'dart:io';
import 'package:catchit/core/helper/calculator.dart';
import 'package:catchit/core/params/download_param.dart';
import 'package:catchit/core/services/internet.dart';
import 'package:catchit/core/utils/global_widgets/modals/network_error.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:catchit/core/helper/app_storage_path.dart';
import 'package:catchit/config/app_config.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'donwnload_success.dart';

class DownloadButton extends ConsumerStatefulWidget {
  const DownloadButton({super.key, required this.param});

  final DownloadBtnParam param;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends ConsumerState<DownloadButton> {
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
        String filePath =
            '${await AppStoragePath().getPath()}/${widget.param.fileName}';
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
          MediaScanner.loadMedia(path: filePath);
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
      if (context.mounted) networkErrorModal(context: context);
      return false;
    }
  }

  startDownload() async {
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
        ref.read(historyProvider).add(
              FileEntity(
                platform: widget.param.platform,
                format: widget.param.isAudio
                    ? 'audio'
                    : widget.param.isVideo
                        ? 'video'
                        : 'image',
                link: widget.param.fileUrl,
                file: file.path,
                title: widget.param.fileName,
                thumb: widget.param.thump,
              ),
            );
        HapticFeedback.vibrate();
        // if (context.mounted) successSaveModal(context: context);
      }
      HapticFeedback.vibrate();
    } else {
      if (mounted) setState(() => isFailed = true);
    }
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
            padding: EdgeInsets.only(bottom: 10.w),
            child: Text(
              widget.param.title as String,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppConfig().fsTitleSmall,
                color: Colors.white,
              ),
            ),
          ),
        if (isSuccess)
          DownlodaSuccess(
            param: widget.param,
            file: file,
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
            padding: EdgeInsets.only(top: 10.w),
            child: Text(
              networkError!,
              style: TextStyle(
                  color: Colors.red, fontSize: AppConfig().fsTextSmall),
            ),
          ),
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
      borderRadius: BorderRadius.circular(12.r),
      child: showProgress
          ? ColoredBox(
              color: AppConfig.lightRed.withOpacity(0.2),
              child: SizedBox(
                width: double.infinity,
                height: 45.w,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 45.w,
                      width: (1.sw - 40.w) * progress / 100,
                      color: isFailed
                          ? const Color(0xFFFC564A)
                          : AppConfig.lightRed,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isFailed)
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
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
                            fontSize: AppConfig().fsTitleSmall,
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
              height: 45.w,
              color: isFailed ? const Color(0xFFFC564A) : AppConfig.lightRed,
              child: isFailed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
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
                            fontSize: AppConfig().fsTitleSmall,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: SizedBox(
                        width: 30.w,
                        height: 30.w,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      ),
                    ),
            ),
    );
  }
}
