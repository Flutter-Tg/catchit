// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/services/privacy.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => SystemNavigator.pop(),
                  child: Text(
                    'Disagree',
                    style: TextStyle(
                      fontSize: ThemeConstants().fsText,
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.lightGray,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 170,
                height: 170,
                child: Lottie.asset('assets/lottie/privacy.json'),
              ),
              const SizedBox(height: 15),
              Text(
                'Privacy & Policy',
                style: TextStyle(
                  fontSize: ThemeConstants().fsBanner,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
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
                      fontSize: ThemeConstants().fsTitleSmall,
                      fontWeight: FontWeight.w500,
                    ),
                    children: const [
                      TextSpan(text: 'You need to accept the '),
                      TextSpan(
                        text: 'Privacy & Policy',
                        style: TextStyle(
                            color: ThemeConstants.green,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                          text:
                              ' of using the Catchit application to continue using'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
