import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.label, this.padding});

  final String label;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Container(
        color: colorScheme.tertiary,
        // color: Colors.red.shade400,
        child: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: colorScheme.onTertiary)
              // backgroundColor: AppTheme.darkPink)
              ),
        ),
      ),
    );
  }
}
