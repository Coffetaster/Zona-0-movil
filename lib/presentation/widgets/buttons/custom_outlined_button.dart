import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key, this.icon, required this.label, this.onPressed});

  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))));
    return icon != null
        ? OutlinedButton.icon(
            style: buttonStyle,
            label: Text(label.toUpperCase()),
            icon: Icon(icon),
            onPressed: onPressed,
          )
        : OutlinedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(label.toUpperCase()),
          );
  }
}
