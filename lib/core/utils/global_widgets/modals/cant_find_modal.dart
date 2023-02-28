import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

cantFindModal({required BuildContext context, String? text}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: CantFindModal(screenContext: context, text: text),
    ),
  );
}

class CantFindModal extends HookWidget {
  const CantFindModal({super.key, required this.screenContext, this.text});
  final BuildContext screenContext;
  final String? text;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: 120,
                child: Lottie.asset('assets/lottie/empty_box.json'),
              ),
              const SizedBox(height: 10),
              Text(
                'Sorry !!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeConstants().fsTitleSmall,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text ??
                    "We can't get any Detail from this Link.\nif this Link is not Broken or Private, Please Report to Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ThemeConstants().fsText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              PrimaryButtonWidget(
                backgroundColor: ThemeConstants.gray,
                text: 'Got it',
                async: false,
                function: () {
                  Navigator.pop(screenContext);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
