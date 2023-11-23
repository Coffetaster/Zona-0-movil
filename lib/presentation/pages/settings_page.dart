import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/shared/theme_change.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemeChangeWidget(),
      ],
    );
  }
}