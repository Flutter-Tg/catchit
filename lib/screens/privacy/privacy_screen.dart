// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenHead(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.w),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => SystemNavigator.pop(),
                  child: Text(
                    'Disagree',
                    style: TextStyle(
                      fontSize: AppConfig().fsText,
                      fontWeight: FontWeight.w500,
                      color: AppConfig.lightGray,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 170.w,
                height: 170.w,
                child: Lottie.asset('assets/lottie/privacy.json'),
              ),
              SizedBox(height: 15.w),
              Text(
                'Privacy & Policy',
                style: TextStyle(
                  fontSize: AppConfig().fsBanner,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.w),
              InkWell(
                onTap: () async {
                  try {
                    await launchUrlString('https://catchit.live/privacy-policy',
                        mode: LaunchMode.externalApplication);
                  } catch (e) {
                    await launchUrlString('https://catchit.live/privacy-policy',
                        mode: LaunchMode.platformDefault);
                  }
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: AppConfig().fsTitleSmall,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
                      TextSpan(text: 'You need to accept the '),
                      TextSpan(
                        text: 'Privacy & Policy',
                        style: TextStyle(
                            color: AppConfig.red,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                          text:
                              ' of using the Catchit application to continue using'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.w),
              PrimaryButtonWidget(
                text: 'Accept and Continue',
                async: true,
                function: () async {
                  final result = await PrivacyService().accept();
                  await Future.delayed(const Duration(seconds: 2));
                  if (result == true) {
                    ref.read(routerProvider).goNamed('onboarding');
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
