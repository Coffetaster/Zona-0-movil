import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class IconSubtextButton extends StatelessWidget {
  const IconSubtextButton({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: null,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
          onPressed: onTap,
          child: Icon(icon),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ],
    );
  }
}