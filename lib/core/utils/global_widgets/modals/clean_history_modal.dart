import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool?> cleanHistoryModal(
    {required BuildContext context, String? text, String? title}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
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
    return ShowScaleAnimation(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ThemeConstants.black,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 120,
              //   child: Lottie.asset('assets/lottie/empty_box.json'),
              // ),
              // const SizedBox(height: 10),
              Text(
                title ?? 'Clean History',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeConstants().fsTitleSmall,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text ??
                    "Are you sure you want to clear the history? You lose all of your History.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeConstants().fsText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              PrimaryButtonWidget(
                text: 'Delete All',
                async: true,
                function: () async {
                  await ref.read(historyProvider).clearHisory();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(screenContext, true);
                },
              ),
              const SizedBox(height: 10),
              PrimaryButtonWidget(
                backgroundColor: ThemeConstants.gray,
                text: 'Decline',
                async: false,
                function: () {
                  Navigator.pop(screenContext, false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
