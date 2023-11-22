import 'package:flutter/material.dart';
import 'package:zona0_apk/main.dart';

class CustomInmutableText extends StatelessWidget {
  const CustomInmutableText(
      {super.key,
      required this.title,
      this.subTitle,
      this.icon,
      this.onActionPressed,
      this.tooltip,
      this.onDelete});
  final String title;
  final String? subTitle;
  final IconData? icon;
  final VoidCallback? onActionPressed;
  final VoidCallback? onDelete;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if(onDelete != null)
            IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.8)),
                tooltip: AppLocalizations.of(context)!.eliminar,
              ),

            if(onActionPressed != null && icon != null)
            IconButton(
                onPressed: onActionPressed,
                icon: Icon(icon),
                tooltip: tooltip,
              ),
          ],
        )
      ),
    );
  }
}
