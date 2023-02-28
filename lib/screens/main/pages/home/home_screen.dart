import 'dart:io';

import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:catchit/screens/main/main_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home_controller.dart';
import 'widgets/link_box.dart';
import 'widgets/recent.dart';
import 'widgets/platform_item.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController linkController = TextEditingController();
    return ScreenHead(
        child: Stack(
      children: [
        Column(
          children: [
            SafeArea(
              bottom: false,
              child: AppBarWidget(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                leftChild: InkWell(
                  onTap: () {
                    ref.read(zoomDrawerKeyProvider).currentState!.openDrawer();
                  },
                  child: Icon(Icons.menu, size: 26.sp),
                ),
                centerChild: Image.asset(
                  'assets/logo/logo.png',
                  width: 90,
                  height: 22,
                  fit: BoxFit.contain,
                ),
                rightChild: InkWell(
                  onTap: () => ref.read(routerProvider).pushNamed('mySpace'),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Text(
                        'MY🪐SPACE',
                        style: TextStyle(
                          fontSize: ThemeConstants().fsSmall,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  RecentList(),
                  //!ads
                  // const BannerAdWidget(
                  //   padding: EdgeInsets.only(bottom: 5, top: 5),
                  //   emptyHight: 0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Download ',
                              style: TextStyle(
                                fontSize: ThemeConstants().fsTitleSmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Media & Content',
                              style: TextStyle(
                                fontSize: ThemeConstants().fsTitleSmall,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
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
                        const SizedBox(height: 20),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            color: ThemeConstants.blackGray,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                            children: [
                              LinkBox(
                                function: () async => await HomeController()
                                    .searchLink(
                                        linkController.text, ref, context),
                                textEditingController: linkController,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      'Share Automaticly in 🪐 Space',
                                      style: TextStyle(
                                        fontSize: ThemeConstants().fsText,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // const BannerAdWidget(
                  //     padding: EdgeInsets.symmetric(vertical: 20)),
                ],
              ),
            )),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Builder(
            builder: (context) {
              final zoomKey = ref.read(zoomDrawerKeyProvider).currentState!;
              return GestureDetector(
                dragStartBehavior: DragStartBehavior.start,
                behavior: HitTestBehavior.translucent,
                excludeFromSemantics: true,
                onHorizontalDragUpdate: (details) async {
                  double delta = details.primaryDelta! / 1.sw;
                  zoomKey.controller.value += delta;
                },
                onHorizontalDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dx.abs() >= 1.sw) {
                    double visualVelocity =
                        details.velocity.pixelsPerSecond.dx / 1.sw;
                    zoomKey.controller.fling(velocity: visualVelocity);
                  } else if (zoomKey.controller.value >= 0.5) {
                    zoomKey.openDrawer();
                  } else {
                    zoomKey.closeDrawer();
                  }
                },
                child: IgnorePointer(
                  child: SizedBox(
                    height: double.infinity,
                    width: 0.1.sw,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
