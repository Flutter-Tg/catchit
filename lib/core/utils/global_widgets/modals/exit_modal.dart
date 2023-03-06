import 'dart:io';

import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/ads/exit.dart';
import 'package:catchit/core/utils/global_widgets/modals/model_body.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

exitModal({required BuildContext context}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => ModalBody(
      child: ExitModal(
        screenContext: context,
      ),
    ),
  );
}

class ExitModal extends ConsumerWidget {
  const ExitModal({super.key, required this.screenContext});
  final BuildContext screenContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExitBannerWidget(padding: EdgeInsets.only(bottom: 20.w)),
          Text(
            'Are you sure to Exit?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsTitleSmall,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            "Double check before you proceed.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsText,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30.w),
          PrimaryButtonWidget(
            backgroundColor: AppConfig.lightRed,
            text: 'Cancel',
            async: false,
            function: () {
              ref.read(routerProvider).pop();
            },
          ),
          const SizedBox(height: 10),
          PrimaryButtonWidget(
            backgroundColor: AppConfig.gray,
            text: 'Exit',
            async: false,
            function: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
