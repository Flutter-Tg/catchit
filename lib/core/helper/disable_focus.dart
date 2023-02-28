import 'package:flutter/material.dart';

disableFocus() {
  if (FocusManager.instance.primaryFocus != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
