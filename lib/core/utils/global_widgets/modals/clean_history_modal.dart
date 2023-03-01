import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/model_body.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> cleanHistoryModal(
    {required BuildContext context, String? text, String? title}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => ModalBody(
      child:
          CleanHistoryModal(screenContext: context, text: text, title: title),
    ),
  );
}

class CleanHistoryModal extends ConsumerWidget {
  const CleanHistoryModal({
    super.key,
    required this.screenContext,
    this.text,
    this.title,
  });
  final BuildContext screenContext;
  final String? text;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Clean History',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsTitleSmall,
              fontWeight: FontWeight.w700,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            text ??
                "Are you sure you want to clear the history? You lose all of your History.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsText,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30.w),
          PrimaryButtonWidget(
            text: 'Delete All',
            async: true,
            function: () async {
              await ref.read(historyProvider).clearHisory();
              // ignore: use_build_context_synchronously
              ref.read(routerProvider).pop(true);
            },
          ),
          SizedBox(height: 10.w),
          PrimaryButtonWidget(
            backgroundColor: AppConfig.gray,
            text: 'Decline',
            async: false,
            function: () {
              ref.read(routerProvider).pop(false);
            },
          ),
        ],
      ),
    );
  }
}
