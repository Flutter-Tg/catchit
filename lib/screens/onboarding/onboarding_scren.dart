import 'package:catchit/core/utils/animations/cahnge_text_animation.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  int pageIndex = 0;
  late AnimationController controller;
  // late AnimationController controller2;
  late AnimationController btnController;
  late Animation<double> opacity;
  late Animation<double> translate;
  GlobalKey<ChangeTextAnimationState> changeTextKey = GlobalKey();

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    btnController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    translate = Tween(begin: 10.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    Future.delayed(
      const Duration(milliseconds: 400),
      () => controller.forward(),
    );
    super.initState();
  }

  next() async {
    if (controller.isAnimating == false) {
      if (pageIndex == 0) {
        btnController.forward();
        changeTextKey.currentState!.changeText('NEXT');
      } else if (pageIndex == 4) {
        changeTextKey.currentState!.changeText('Continue');
      }

      if (pageIndex == 5) {
        ref.read(routerProvider).goNamed('main');
      } else {
        await controller.reverse();
        setState(() => pageIndex = pageIndex + 1);
        await Future.delayed(const Duration(milliseconds: 200));
        await controller.forward();
      }
    }
  }

  back() async {
    if (controller.isAnimating == false && pageIndex != 0) {
      if (pageIndex == 1) {
        changeTextKey.currentState!.changeText('START');
        btnController.reverse();
      } else if (pageIndex == 5) {
        changeTextKey.currentState!.changeText('NEXT');
      }

      await controller.reverse();
      setState(() => pageIndex = pageIndex - 1);
      await Future.delayed(const Duration(milliseconds: 200));
      await controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenHead(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 0) {
            next();
          } else {
            back();
          }
        },
        child: ColoredBox(
          color: AppConfig.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SafeArea(
                bottom: false,
                child: AnimatedBuilder(
                  animation: controller,
                  child: Image.asset(
                    contentsBack[pageIndex],
                    width: double.infinity,
                  ),
                  builder: (context, child) => FadeTransition(
                    opacity: opacity,
                    child: Transform.translate(
                      offset: Offset(0, translate.value),
                      child: child,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: pageIndex == 5 ? 0.65.sw : 0.6.sw,
                left: 20.w,
                right: 20.w,
                child: AnimatedBuilder(
                  animation: controller,
                  child: contents[pageIndex],
                  builder: (context, child) => FadeTransition(
                    opacity: opacity,
                    child: Transform.translate(
                      offset: Offset(0, -translate.value),
                      child: child,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.4.sw,
                left: 20.w,
                right: 20.w,
                child: AnimatedBuilder(
                  animation: btnController,
                  builder: (context, child) => Row(
                    children: [
                      SizedBox(
                        width: Tween<double>(begin: 0, end: 120.w)
                            .animate(CurvedAnimation(
                                parent: btnController, curve: Curves.ease))
                            .value,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: SizedBox(
                              width: 100.w,
                              child: PrimaryButtonWidget(
                                text: 'BACK',
                                async: false,
                                backgroundColor: const Color(0xff151515),
                                function: () async => back(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async => next(),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: AppConfig.lightRed,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: SizedBox(
                              height: 45.w,
                              child: Center(
                                child: ChangeTextAnimation(
                                  key: changeTextKey,
                                  text: 'START',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AppConfig().fsTitleSmall,
                                  ),
                                  duration: const Duration(milliseconds: 200),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30.w,
                child: AnimatedBuilder(
                  animation: btnController,
                  child: InkWell(
                    onTap: () => ref.read(routerProvider).goNamed('main'),
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConfig().fsTitleSmall,
                        color: const Color(0xff686868),
                      ),
                    ),
                  ),
                  builder: (context, child) => FadeTransition(
                    opacity: Tween<double>(begin: 1, end: 0).animate(
                        CurvedAnimation(
                            parent: btnController, curve: Curves.ease)),
                    child: ScaleTransition(
                        scale: Tween<double>(begin: 1, end: 0).animate(
                            CurvedAnimation(
                                parent: btnController, curve: Curves.ease)),
                        child: child),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> contentsBack = [
    //welcom
    'assets/images/ob_welcome.png',
    // catch
    'assets/images/ob_catch.png',
    // space
    'assets/images/ob_space.png',
    // donwload
    'assets/images/ob_download.png',
    // share
    'assets/images/ob_share.png',
    // final
    'assets/images/ob_final.png',
  ];
  List<Widget> contents = [
    //welcom
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome to',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConfig().fsBannerSmall,
          ),
        ),
        SizedBox(height: 10.w),
        Image.asset('assets/logo/logo.png', width: 110.w, height: 28.w),
        SizedBox(height: 25.w),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280.w),
          child: Text(
            'Take a few steps to know what you can do with us🤩',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppConfig().fsTitleSmall,
            ),
          ),
        ),
      ],
    ),
    // catchit
    Text(
      'Catch\nAnything you\nWant Quickly',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConfig().fsBannerSmall,
      ),
    ),
    // space
    Text(
      'Browse\nBetween Multi\nSocial Media\nin 🪐 Space',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConfig().fsBannerSmall,
      ),
    ),
    // donwload
    Text(
      'Access\nTo Download\nHigh-Quality\nMedia & Audio',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConfig().fsBannerSmall,
      ),
    ),
    // share
    Text(
      'Share\nBetween your\nFriends',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: AppConfig().fsBannerSmall,
      ),
    ),
    // final
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Now,\nLet’s Start to\nBrowse and\nDownload in",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppConfig().fsBannerSmall,
          ),
        ),
        SizedBox(height: 5.w),
        Image.asset('assets/logo/logo.png',
            width: 220.w, height: 56.w, fit: BoxFit.contain),
      ],
    ),
  ];
}
