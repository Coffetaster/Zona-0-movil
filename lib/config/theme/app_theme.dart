import 'dart:ui';

import 'package:flutter/material.dart';

const List<Color> colorThemes = [
  Color(0xffe46b10),
  Color(0xffE65829),
  Color(0xFFff8947),
  Color(0xFFfea454),
  Color(0xFF121212),
];

class AppTheme {
  int selectedColor;
  final bool isDark;

  AppTheme({this.selectedColor = 0, this.isDark = false});

  ThemeData theme() => _theme(isDark);
  ThemeData themeLight() => _theme(false);
  ThemeData themeDark() => _theme(true);

  ThemeData _theme(bool isDarkMode) {
    // GoogleFonts.mulish()
    Color colorPrimary = colorThemes[selectedColor % colorThemes.length];
    ThemeData td = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorPrimary,
        // primary: colorPrimary,
        primary: isDarkMode ? null : colorPrimary,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        // background: isDarkMode ? const Color(0xFF000000) : const Color(0xFFf9f9f9),
        background: isDarkMode ? const Color(0xFF000000) : null,
        surface: isDarkMode ? const Color(0xFF121212) : null,
        primaryContainer: isDarkMode ? const Color(0xFF121212) : null,
        secondaryContainer: isDarkMode ? const Color(0xFF121212) : null,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        // elevation: 20,
      ),
    );
    return td;
  }

  /*
  ThemeData _theme(bool isDarkMode) {
    Color colorPrimary = colorThemes[selectedColor % colorThemes.length];
    ThemeData td = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorPrimary,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        // elevation: 20,
      ),
    );
    Color colorPrimaryDark = td.colorScheme.secondary;
    td = td.copyWith(
      colorScheme: td.colorScheme.copyWith(
        primary: td.brightness == Brightness.light ? colorPrimary : colorPrimaryDark
      ),
    );
    return td;
  }
  */

  AppTheme copyWith({
    int? selectedColor,
    bool? isDark,
  }) {
    return AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDark: isDark ?? this.isDark,
    );
  }

  static Color perfectGrey = Color(0xfff1f1f1);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];
  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static const double borderRadius = 20;
}
