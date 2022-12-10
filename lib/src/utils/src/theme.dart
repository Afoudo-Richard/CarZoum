import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carzoum/src/utils/src/style.dart';

ThemeData? appTheme(BuildContext context) {
  return ThemeData(
    platform: TargetPlatform.iOS,
    fontFamily: 'Rubik',
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: primaryColor, // but now it should be declared like this
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      titleTextStyle: Theme.of(context).textTheme.headline6,
      systemOverlayStyle: SystemUiOverlayStyle.dark, //
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(13),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(13),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
