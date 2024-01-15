import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

enum FilledButtonType {
  normal,
  tonal,
}

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key,
      this.icon,
      required this.label,
      this.onPressed,
      this.filledButtonType = FilledButtonType.normal});

  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;
  final FilledButtonType filledButtonType;

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))));

    if (filledButtonType == FilledButtonType.normal) {
      return icon != null
          ? FilledButton.icon(
              style: buttonStyle,
              label: Text(label.toUpperCase()),
              icon: Icon(icon),
              onPressed: onPressed,
            )
          : FilledButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: Text(label.toUpperCase()),
            );
    } else {
      return icon != null
          ? FilledButton.tonalIcon(
              style: buttonStyle,
              label: Text(label.toUpperCase()),
              icon: Icon(icon),
              onPressed: onPressed,
            )
          : FilledButton.tonal(
              style: buttonStyle,
              onPressed: onPressed,
              child: Text(label.toUpperCase()),
            );
    }
  }
}
