import 'package:flutter/material.dart';

const List<Color> colorThemes = [
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
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorThemes[selectedColor % colorThemes.length],
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          // elevation: 20,
        ),
    );
  }

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

