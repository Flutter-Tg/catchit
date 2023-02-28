import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/appbar_widget.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:catchit/screens/main/main_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsPage extends ConsumerWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(pageIndexProvider.notifier).state = 0;
        return false;
      },
      child: ScreenHead(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: AppBarWidget(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                leftChild: InkWell(
                  onTap: () {
                    ref.read(pageIndexProvider.notifier).state = 0;
                  },
                  child: Icon(Icons.arrow_back, size: 26.sp),
                ),
                centerChild: Text(
                  'About Catchit',
                  style: TextStyle(
                    fontSize: ThemeConstants().fsTitleSmall,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset('assets/logo/logo.png',
                        width: 220, height: 56, fit: BoxFit.contain),
                    const SizedBox(height: 50),
                    Text(
                      'We are Catchit🌟\nThe Application you can Browse and Download the Bests Between Trillions of media from Popular Social Media as quickly as we can. The new version of Social Browsing is in your hands.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ThemeConstants().fsTitleSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      'We have great news in upcoming updates. So keep with us✌️',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ThemeConstants().fsTitr,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButtonWidget(
                      backgroundColor: ThemeConstants.gray,
                      text: 'Open Website',
                      async: false,
                      function: () async {
                        try {
                          await launchUrlString('https://catchit.live',
                              mode: LaunchMode.externalApplication);
                        } catch (e) {
                          await launchUrlString('https://catchit.live',
                              mode: LaunchMode.platformDefault);
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
