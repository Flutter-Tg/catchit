import 'dart:io';

import 'package:catchit/config/app_info.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenHead(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Lottie.asset(
                'assets/lottie/update.json',
                width: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 15),
              Text(
                'New Update is Now Available🤩',
                style: TextStyle(
                  fontSize: ThemeConstants().fsTitrSub,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You must update the application for access to new features and important problem fixes. The new version is now available in Google Play',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeConstants().fsText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButtonWidget(
                text: 'UPDATE NOW',
                async: true,
                function: () async {
                  String link = '';
                  if (Platform.isAndroid) {
                    link = AppInfo.googlePalyLink;
                  } else if (Platform.isIOS) {
                    link = AppInfo.appStorPalyLink;
                  }
                  try {
                    await launchUrlString(link,
                        mode: LaunchMode.externalApplication);
                  } catch (e) {
                    await launchUrlString(link,
                        mode: LaunchMode.platformDefault);
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
