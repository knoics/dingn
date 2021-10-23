import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  static const Color primaryColor = Color.fromRGBO(84, 197, 248, 1);
  static const Color secondaryColor = Color.fromRGBO(1, 87, 155, 1);
  static const Color accentColor = Color.fromRGBO(255, 86, 120, 1);
  static const Color alternateColor = Color.fromRGBO(255, 224, 116, 1);
  static const Color fadedBlackColor = Color.fromRGBO(32, 33, 36, 1);
  static Color? errorColor = Colors.red[300];

  static const fontFamilyWorkSans = 'WorkSans';
  static const fontFamilyOpenSans = 'OpenSans';
  static const fontFamilyDefault = fontFamilyOpenSans;

  static const fontWeightExtraLight = FontWeight.w200;
  static const fontWeightLight = FontWeight.w300;
  static const fontWeightNormal = FontWeight.w400;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightSemiBold = FontWeight.w600;
  static const fontWeightBold = FontWeight.w700;

  static const double fontSizeMedium = 16;
  static const double fontSizeFootnote = 10;
  static const double fontSizeTiny = 6;
  static const double fontSizeIconButtonText = 12;
  static const double fontSizeBrand = 20;
  static ThemeData theme() {
    final theme = ThemeData(
      primaryColor: primaryColor,
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.normal),
      dividerColor: accentColor,
      errorColor: errorColor,
      // scaffoldBackgroundColor: Colors.grey[100],
      textTheme: const TextTheme(
        // display1: TextStyle(
        //   fontSize: 28,
        //   fontFamily: fontFamilyWorkSans,
        // ),
        // title: TextStyle(
        //   fontFamily: fontFamilyWorkSans
        // ),
        bodyText1: TextStyle(
          fontSize: fontSizeMedium,
        ),
        bodyText2: TextStyle(
          fontSize: fontSizeMedium,
        ),
        button: TextStyle(
          fontSize: fontSizeMedium,
        ),
      ),
      fontFamily: fontFamilyDefault,
      primaryIconTheme: const IconThemeData(
        color: accentColor,
        size: 30,
      ),
      iconTheme: const IconThemeData(
        color: accentColor,
        size: 30,
      ),
    );
    theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: accentColor));
    return theme;
  }
}
