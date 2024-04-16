import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';

import '../extention/custom_theme_extention.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: const ColorScheme.light(background: Coloors.backgroundLight),
      scaffoldBackgroundColor: Coloors.backgroundLight,
      extensions: [
        CustomThemeExtention.lightMode,
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Coloors.greenLight,
          foregroundColor: Coloors.backgroundLight,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ));
}
