import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/scroll_can_body.dart';
import 'package:catchit/screens/main/main_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ZoomDrawer extends StatefulWidget {
  const ZoomDrawer({super.key, required this.child});
  final Widget child;

  @override
  State<ZoomDrawer> createState() => ZoomDrawerState();
}

class ZoomDrawerState extends State<ZoomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> translateX;
  late Animation<double> radius;
  bool isMenuOpen = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    scale = Tween<double>(begin: 1, end: 0.9)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    translateX = Tween<double>(begin: 0.0, end: 0.55.sw).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );
    radius = Tween<double>(begin: 0.0, end: 50)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));

    controller.addListener(() {
      if (controller.isCompleted) {
        setState(() => isMenuOpen = true);
      } else if (controller.isDismissed) {
        setState(() => isMenuOpen = false);
      }
    });
    super.initState();
  }

  openDrawer() async {
    await controller.forward();
    setState(() => isMenuOpen = true);
  }

  closeDrawer() async {
    await controller.reverse();
    setState(() => isMenuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(199, 81, 255, 0.2),
            Color.fromRGBO(255, 151, 30, 0.2),
            Color.fromRGBO(167, 0, 00, 0.2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          ScrollCanBody(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Image.asset('assets/logo/logo.png',
                      height: 25, fit: BoxFit.contain),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final pageIndex = ref.watch(pageIndexProvider.notifier);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              pageIndex.state = 0;
                              closeDrawer();
                            },
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                                color: pageIndex.state == 0
                                    ? AppConfig.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () {
                              pageIndex.state = 1;
                              closeDrawer();
                            },
                            child: Text(
                              'About us',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                                color: pageIndex.state == 1
                                    ? AppConfig.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () async {
                              try {
                                await launchUrlString(
                                    'https://catchit.live/privacy-policy',
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                await launchUrlString(
                                    'https://catchit.live/privacy-policy',
                                    mode: LaunchMode.platformDefault);
                              }
                            },
                            child: Text(
                              'Privacy & Policy',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri(
                                scheme: 'mailto',
                                path: 'problems@catchit.live',
                              ));
                            },
                            child: Text(
                              'Report a Bug',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri(
                                  scheme: 'mailto',
                                  path: 'feedbacks@catchit.live'));
                            },
                            child: Text(
                              'Send a Feedback',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri(
                                  scheme: 'mailto', path: 'hi@catchit.live'));
                            },
                            child: Text(
                              'Contact us',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(height: 0.07.sw),
                          InkWell(
                            onTap: () async {
                              try {
                                await launchUrlString('https://catchit.live',
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                await launchUrlString('https://catchit.live',
                                    mode: LaunchMode.platformDefault);
                              }
                            },
                            child: Text(
                              'Open Website',
                              style: TextStyle(
                                fontSize: AppConfig().fsTitleSmall,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          // SizedBox(height: 0.07.sw),
                          // RewardAdWidget(
                          //   adUnitId: AdsService.rewardedAdUnitId,
                          //   child: Text(
                          //     '😍 Donate Us',
                          //     style: TextStyle(
                          //       fontSize: AppConfig().fsTitleSmall,
                          //       fontWeight: FontWeight.w300,
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 0.05.sw),
                InkWell(
                  onTap: () {
                    final box = context.findRenderObject() as RenderBox?;
                    Share.share(
                        '''😎Download and Browse between Post, Story, Reels, Video, Music⚡️from Instagram, TikTok and Facebook with Catchit Application.
              
              ✳️ Download Now For Android:
              ${AppConfig.googlePalyLink}''',
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size);
                  },
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffFF9900),
                            Color(0xffC95A1C),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🥳',
                            style: TextStyle(
                              fontSize: AppConfig().fsTitleSmall,
                              height: 0.7,
                            ),
                          ),
                          Text(
                            'Share with Friends',
                            style: TextStyle(
                              fontSize: AppConfig().fsTitleSmall,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: () => closeDrawer(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 26.sp,
                          color: const Color(0xff7b7b7b),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Close Menu',
                          style: TextStyle(
                            fontSize: AppConfig().fsTitleSmall,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff7b7b7b),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.2.sw),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.copyright_rounded,
                        size: 18.sp,
                        color: const Color(0xff7b7b7b),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Copyright 2022\nCatchit  v${AppConfig.appVersion}',
                        style: TextStyle(
                          fontSize: AppConfig().fsSmall,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff7b7b7b),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                dragStartBehavior: DragStartBehavior.start,
                behavior: HitTestBehavior.translucent,
                excludeFromSemantics: true,
                onTap: () => closeDrawer(),
                onHorizontalDragUpdate: (details) {
                  double delta = details.primaryDelta! / 0.55.sw;
                  controller.value += delta;
                },
                onHorizontalDragEnd: (details) {
                  if (details.velocity.pixelsPerSecond.dx.abs() >= 1.sw) {
                    double visualVelocity =
                        details.velocity.pixelsPerSecond.dx / 1.sw;
                    controller.fling(velocity: visualVelocity);
                  } else if (controller.value >= 0.5) {
                    openDrawer();
                  } else {
                    closeDrawer();
                  }
                },
                child: IgnorePointer(
                  ignoring: isMenuOpen ? true : false,
                  child: widget.child,
                ),
              ),
            ),
            builder: (context, childWidget) {
              return Transform.scale(
                scale: scale.value,
                child: Transform.translate(
                  offset: Offset(translateX.value, 0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(radius.value),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 80, color: Color.fromRGBO(0, 0, 0, 0.8))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius.value),
                      child: childWidget,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
