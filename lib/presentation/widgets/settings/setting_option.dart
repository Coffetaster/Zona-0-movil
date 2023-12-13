import 'package:flutter/material.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class SettingOption extends StatelessWidget {
  const SettingOption({
      super.key,
      required this.title,
      this.subtitle,
      required this.icon,
      this.trailing,
      this.onTap
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius))
        ),
        child: Icon(icon)),
      title: Text(title, style: Theme.of(context).textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.bold,
      )),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
    );
  }
}
