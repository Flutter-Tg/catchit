import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:catchit/core/utils/global_widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:catchit/core/params/download_param.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/network_imag_fade_widget.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/show_delay.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:catchit/screens/detail/widgets/donwload_button.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.data});
  final DetailEntity data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> items = [
      if (data.images != null && data.images!.isNotEmpty)
        ImageDetailItem(data: data),
      if (data.videos != null && data.videos!.isNotEmpty)
        VideosDetailItem(data: data),
      if (data.audios != null && data.audios!.isNotEmpty)
        AudioDetailItem(data: data),
      if (data.caption != null && data.caption!.title != null)
        CaptionItem(title: 'Title', sub: data.caption!.title.toString()),
      if (data.caption != null && data.caption!.description != null)
        CaptionItem(
            title: 'Description', sub: data.caption!.description.toString()),
    ];
    return ScreenHead(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            ref.read(routerProvider).pop();
          }
        },
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                AppBarWidget(
                  leftChild: InkWell(
                    onTap: () => ref.read(routerProvider).pop(),
                    child: Icon(
                      Icons.arrow_back,
                      size: 26.sp,
                    ),
                  ),
                  centerChild: Text(
                    'See Content',
                    style: TextStyle(
                      fontSize: AppConfig().fsTitleSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  rightChild: data.platform != 'spotify' &&
                          data.platform != 'youtube' &&
                          data.platform != 'youtub_music'
                      ? InkWell(
                          onTap: () async {
                            try {
                              await launchUrlString(data.link,
                                  mode: LaunchMode.externalApplication);
                            } catch (e) {
                              await launchUrlString(data.link,
                                  mode: LaunchMode.platformDefault);
                            }
                          },
                          onLongPress: () {
                            HapticFeedback.vibrate();
                            Clipboard.setData(
                              ClipboardData(text: data.link),
                            ).then(
                              (value) => Fluttertoast.showToast(
                                  msg: 'Link was Copied'),
                            );
                          },
                          child: Image.asset(
                            'assets/icons/${data.platform}.png',
                            width: 20.w,
                            height: 20.w,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: ShowDelay(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.owner != null)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.w),
                              child: Row(
                                children: [
                                  if (data.owner!.profileUrl != null)
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: NetworkImageFadeWidget(
                                        width: 30.w,
                                        height: 30.w,
                                        imageUrl: data.owner!.profileUrl,
                                        radius: 30.r,
                                      ),
                                    ),
                                  Text(
                                    data.owner!.username,
                                    style: TextStyle(
                                      fontSize: AppConfig().fsText,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 30.w),
                            itemBuilder: (context, index) => items[index],
                          ),
                          SizedBox(height: 20.w),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageDetailItem extends StatelessWidget {
  const ImageDetailItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DetailEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.images!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 1.sh * 0.7),
                  child: SizedBox(
                    width: 1.sw,
                    child: NetworkImageFadeWidget(
                      width: double.infinity,
                      imageUrl: data.images![index].url,
                      radius: 8,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DownloadButton(
                  param: DownloadBtnParam(
                      platform: data.platform,
                      thump: data.thumb,
                      title: data.images![index].title,
                      fileUrl: data.images![index].url,
                      fileName:
                          '${data.images![index].name}-(www.catchit.live).${data.images![index].type}',
                      fileSize: data.images![index].size,
                      isImage: true),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class VideosDetailItem extends StatelessWidget {
  const VideosDetailItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DetailEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.images != null && data.images!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Video',
              style: TextStyle(
                fontSize: AppConfig().fsTitrSub,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.videos!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 1.sh * 0.8, minHeight: 1.sw),
                child: SizedBox(
                  width: 1.sw,
                  child: VideoAutoPlayerWidget(
                    width: double.infinity,
                    url: data.videos![0].url,
                    radius: 8,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DownloadButton(
                param: DownloadBtnParam(
                  platform: data.platform,
                  thump: data.thumb,
                  title: data.videos![index].title,
                  fileUrl: data.videos![index].url,
                  fileName:
                      '${data.videos![index].name}-(www.catchit.live).${data.videos![index].type}',
                  fileSize: data.videos![index].size,
                  isVideo: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AudioDetailItem extends StatelessWidget {
  const AudioDetailItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DetailEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Audio',
          style: TextStyle(
            fontSize: AppConfig().fsTitrSub,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.audios!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => DownloadButton(
            param: DownloadBtnParam(
              platform: data.platform,
              thump: data.thumb,
              title: data.audios![index].title,
              fileUrl: data.audios![index].url,
              fileName:
                  '${data.audios![index].name}-(www.catchit.live).${data.audios![index].type}',
              fileSize: data.audios![index].size,
              isAudio: true,
            ),
          ),
        ),
      ],
    );
  }
}

class CaptionItem extends StatelessWidget {
  const CaptionItem({
    Key? key,
    required this.title,
    required this.sub,
  }) : super(key: key);
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppConfig().fsTitrSub,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          sub,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: AppConfig().fsText,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButtonWidget(
          backgroundColor: AppConfig.gray,
          icon: Icons.file_copy_outlined,
          text: 'Copy to Clipboard',
          async: false,
          function: () {
            Clipboard.setData(
              ClipboardData(text: sub),
            ).then(
              (value) => Fluttertoast.showToast(msg: '$title was Copied'),
            );
          },
        ),
      ],
    );
  }
}
