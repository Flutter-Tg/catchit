import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/link_box.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:catchit/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.w),
                      Row(
                        children: [
                          Text(
                            'Download ',
                            style: TextStyle(
                              fontSize: AppConfig().fsTitleSmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Media & Content',
                            style: TextStyle(
                              fontSize: AppConfig().fsTitleSmall,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.w),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.start,
                          spacing: 10.w,
                          runSpacing: 10.w,
                          children: const [
                            PlatformItem(
                              asset: 'assets/icons/instagram.png',
                              title: 'Instagram',
                            ),
                            PlatformItem(
                              asset: 'assets/icons/tiktok.png',
                              title: 'TikTok',
                            ),
                            PlatformItem(
                              asset: 'assets/icons/facebook.png',
                              title: 'Facebook',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.w),
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
                SizedBox(height: 20.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
