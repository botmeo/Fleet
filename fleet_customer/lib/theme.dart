import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color(0x17414460),
  100: const Color(0x33414460),
  200: const Color(0x4B414460),
  300: const Color(0x66414460),
  400: const Color(0x7E414460),
  500: const Color(0x99414460),
  600: const Color(0xB1414460),
  700: const Color(0xCC414460),
  800: const Color(0xE4414460),
  900: const Color(0xFF414460),
};

MaterialColor primarySwatchColor = MaterialColor(0xFF414460, color);

ThemeData theme() {
  return ThemeData(
    fontFamily: AppFonts.fontsPrimary,
    primarySwatch: primarySwatchColor,
  );
}
