import 'package:flutter/material.dart';

import 'app_config.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: AppConfig.ffIanter,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColor: Colors.blueAccent,
  colorScheme: const ColorScheme.dark().copyWith(
    background: AppConfig.black,
  ),
);
