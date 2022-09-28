import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
  );
}
