import 'dart:io';

import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/core/utils/global_widgets/screen_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Lottie.asset(
                'assets/lottie/update.json',
                width: 250,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 15.w),
              Text(
                'New Update is Now Available🤩',
                style: TextStyle(
                  fontSize: AppConfig().fsTitrSub,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                'You must update the application for access to new features and important problem fixes. The new version is now available in Google Play',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppConfig().fsText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40.w),
              PrimaryButtonWidget(
                text: 'UPDATE NOW',
                async: true,
                function: () async {
                  String link = '';
                  if (Platform.isAndroid) {
                    link = AppConfig.googlePalyLink;
                  } else if (Platform.isIOS) {
                    link = "AppConfig.appStorPalyLink";
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
