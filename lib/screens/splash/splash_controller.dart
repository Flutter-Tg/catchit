import 'package:catchit/core/services/update.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashController {
  checkVersion(BuildContext context) async {
    final result = await UpdateService().checkNewVersion();
    if (result) {
      // ignore: use_build_context_synchronously
      //! fix
      context.goNamed('update');
    }
  }
}
