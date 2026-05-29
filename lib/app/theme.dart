import 'package:flutter/material.dart';
import '../core/constants.dart';

ThemeData buildAppTheme() {
  const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'DM Sans',
      fontSize: 56,
      fontWeight: FontWeight.bold,
      color: colorText,
      fontFeatures: [FontFeature.tabularFigures()],
    ),
    bodyLarge: TextStyle(fontFamily: 'DM Sans', fontSize: 16, color: colorText),
    bodyMedium: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: colorText),
    bodySmall: TextStyle(fontFamily: 'DM Sans', fontSize: 12, color: colorMuted),
    labelLarge: TextStyle(fontFamily: 'DM Sans', fontSize: 14, color: colorMuted),
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colorBackground,
    colorScheme: const ColorScheme.dark(
      surface: colorSurface,
      primary: colorGreen,
    ),
    textTheme: textTheme,
    sliderTheme: const SliderThemeData(
      activeTrackColor: colorGreen,
      inactiveTrackColor: colorElevated,
      thumbColor: colorText,
      overlayColor: Color(0x224A9B6F),
      trackHeight: 4,
    ),
    cardColor: colorSurface,
    dividerColor: colorElevated,
  );
}
