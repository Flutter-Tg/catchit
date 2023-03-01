import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/model_body.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

successSaveModal({required BuildContext context}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => ModalBody(
      child: SuccessSaveModal(screenContext: context),
    ),
  );
}

class SuccessSaveModal extends ConsumerWidget {
  const SuccessSaveModal({super.key, required this.screenContext});
  final BuildContext screenContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/like_a_boss.json', width: 120.w),
          SizedBox(height: 10.w),
          Text(
            'Saved Successfuly!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: AppConfig().fsTitleSmall,
                fontWeight: FontWeight.w700,
                color: AppConfig.red),
          ),
          SizedBox(height: 10.w),
          Text(
            'Now, you can see this file in your Gallery or Player',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsText,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30.w),
          PrimaryButtonWidget(
            backgroundColor: AppConfig.gray,
            text: 'Got it',
            async: false,
            function: () {
              ref.read(routerProvider).pop();
            },
          ),
        ],
      ),
    );
  }
}
