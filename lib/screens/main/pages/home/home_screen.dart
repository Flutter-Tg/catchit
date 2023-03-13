import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/link_box.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/ads/main.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:catchit/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home_controller.dart';
import 'widgets/link_box.dart';
import 'widgets/history.dart';
import 'widgets/platform_item.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController linkController = TextEditingController();
    Future.delayed(const Duration(seconds: 1), () {
      Clipboard.getData(Clipboard.kTextPlain).then((value) {
        if (value != null && value.text != null) {
          if ((value.text!.contains('tiktok') ||
                  value.text!.contains('instagram') ||
                  value.text!.contains('facebook') ||
                  value.text!.contains('fb')) &&
              linkController.text.isEmpty) {
            ref.read(linkBoxProvider).currentState!.add(value.text.toString());
          }
        }
      });
    });
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: AppBarWidget(
            height: 50.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            leftChild: InkWell(
              onTap: () {
                ref.read(zoomDrawerKeyProvider).currentState!.openDrawer();
              },
              child: Icon(Icons.menu, size: 26.sp),
            ),
            centerChild: Image.asset(
              'assets/logo/logo.png',
              width: 90.w,
              height: 22.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HistoryList(),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinkBox(
                        key: ref.read(linkBoxProvider),
                        function: () async {
                          if (linkController.text.isNotEmpty) {
                            DetailEntity? result = await HomeController()
                                .searchLink(linkController.text, context);
                            if (result != null) {
                              ref
                                  .read(routerProvider)
                                  .pushNamed('detail', extra: result);
                              return true;
                            }
                          }
                          return false;
                        },
                        textEditingController: linkController,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PlatformVerticalItem(
                      // asset: 'assets/icons/instagram.png',
                      title: 'Instagram',
                      titleColor: Color(0xffFFB14E),
                      sub: 'Post / Reels / Story',
                    ),
                    LimitedBox(
                      maxWidth: 20.w,
                      child: const SizedBox(width: double.infinity),
                    ),
                    const PlatformVerticalItem(
                      // asset: 'assets/icons/tiktok.png',
                      title: 'TikTok',
                      titleColor: Color(0xffFF5454),
                      sub: 'Video & Audio',
                    ),
                    LimitedBox(
                      maxWidth: 20.w,
                      child: const SizedBox(width: double.infinity),
                    ),
                    const PlatformVerticalItem(
                      // asset: 'assets/icons/facebook.png',
                      title: 'Facebook',
                      titleColor: Color(0xff1877F2),
                      sub: 'Video',
                    ),
                  ],
                ),
                SizedBox(height: 15.w),
                if (BannerConfig.main) const MainBannerWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
