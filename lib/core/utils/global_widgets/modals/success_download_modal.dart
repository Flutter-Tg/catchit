import 'package:catchit/core/helper/disable_focus.dart';
import 'package:catchit/core/utils/animations/show_scale_animation.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

successSaveModal({required BuildContext context}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: SuccessSaveModal(screenContext: context),
    ),
  );
}

class SuccessSaveModal extends StatelessWidget {
  const SuccessSaveModal({super.key, required this.screenContext});
  final BuildContext screenContext;

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
                child: Lottie.asset('assets/lottie/like_a_boss.json'),
              ),
              const SizedBox(height: 10),
              Text(
                'Saved Successfuly!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ThemeConstants().fsTitleSmall,
                    fontWeight: FontWeight.w700,
                    color: ThemeConstants.green),
              ),
              const SizedBox(height: 10),
              Text(
                'Now, you can see this file in your Gallery or Player',
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
