import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/extention/custom_theme_extention.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      colorScheme: const ColorScheme.dark(background: Coloors.backgroundDark),
      scaffoldBackgroundColor: Coloors.backgroundDark,
      extensions: [
        CustomThemeExtention.darkMode,
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenDark,
          foregroundColor: Coloors.backgroundDark,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ));
}
