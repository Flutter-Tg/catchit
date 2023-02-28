import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: ThemeConstants.ffIanter,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColor: ThemeConstants.green,
  colorScheme: const ColorScheme.dark().copyWith(
    background: ThemeConstants.black,
  ),
);
