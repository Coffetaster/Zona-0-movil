import 'dart:ui';

import 'package:flutter/material.dart';

const List<Color> colorThemes = [
  Color(0xffe46b10),
  Color(0xffE65829),
  Color(0xFFff8947),
  Color(0xFFfea454),
];

class AppTheme {
  final int selectedColor;
  final bool isDark;

  AppTheme({this.selectedColor = 0, this.isDark = false});

  ThemeData theme() {
    return _theme(isDark);
  }

  ThemeData themeLight() {
    return _theme(false);
  }

  ThemeData themeDark() {
    return _theme(true);
  }

  ThemeData _theme(bool isDarkMode) {
    Color colorPrimary = colorThemes[selectedColor % colorThemes.length];
    ThemeData td = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colorPrimary,
        primary: isDarkMode ? null : colorPrimary,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
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

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];
  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );
}
