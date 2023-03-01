import 'package:catchit/core/helper/disable_focus.dart';

import 'package:catchit/config/app_config.dart';
import 'package:catchit/core/utils/global_state/route.dart';
import 'package:catchit/core/utils/global_widgets/modals/model_body.dart';
import 'package:catchit/core/utils/global_widgets/primary_button_widget.dart';
import 'package:catchit/future/history/controller.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> deleteItemModal({
  required BuildContext context,
  String? text,
  String? title,
  required List<FileEntity> files,
}) async {
  disableFocus();
  return await showDialog(
    context: context,
    builder: (context) => ModalBody(
      child: DeleteItemModal(
        screenContext: context,
        text: text,
        title: title,
        files: files,
      ),
    ),
  );
}

class DeleteItemModal extends ConsumerWidget {
  const DeleteItemModal({
    super.key,
    required this.screenContext,
    this.text,
    this.title,
    required this.files,
  });
  final BuildContext screenContext;
  final String? text;
  final String? title;
  final List<FileEntity> files;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Delete ${files.length == 1 ? "Item" : "Items"}',
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
                "Are you sure to delete this ${files.length == 1 ? "item" : "items"}?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConfig().fsText,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30.w),
          PrimaryButtonWidget(
            text: files.length == 1 ? "Delete" : "Delete All",
            async: true,
            function: () async {
              await ref.read(historyProvider).delete(files);
              ref.read(routerProvider).pop(true);
            },
          ),
          SizedBox(height: 10.w),
          PrimaryButtonWidget(
            backgroundColor: AppConfig.gray,
            text: 'Decline',
            async: false,
            function: () => ref.read(routerProvider).pop(false),
          ),
        ],
      ),
    );
  }
}
