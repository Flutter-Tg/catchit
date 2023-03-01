import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/model_body.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

cantFindModal({required BuildContext context, String? text}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => ModalBody(
      child: CantFindModal(screenContext: context, text: text),
    ),
  );
}

class CantFindModal extends ConsumerWidget {
  const CantFindModal({super.key, required this.screenContext, this.text});
  final BuildContext screenContext;
  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.w,
            child: Lottie.asset('assets/lottie/empty_box.json'),
          ),
          SizedBox(height: 10.w),
          Text(
            'Sorry !!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsTitleSmall,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            text ??
                "We can't get any Detail from this Link.\nif this Link is not Broken or Private, Please Report to Us",
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
