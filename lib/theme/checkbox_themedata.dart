import 'package:flutter/material.dart';

import '../constants/styles.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.white),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius / 2),
    ),
  ),
  side: const BorderSide(color: whiteColor40),
);
