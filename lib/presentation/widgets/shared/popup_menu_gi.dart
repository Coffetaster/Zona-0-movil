import 'package:flutter/material.dart';

import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

/*
  MODO DE USO
  - Con un widget personalizado, no es necesario ponerle un OnPressed
          PopupMenuGI(
            items: [
              PopupMenuHeaderGI(
                imageProvider: AssetImage(ImagesPath.empty_cart.path),
                label: "Mi perfil",
                onTap: () {}
              ),
              PopupMenuItemGI(icon: Icons.add, label: "Adicionar", onTap: () {}),
              PopupMenuDividerGI(height: 8),
              PopupMenuItemGI(label: "Borrar", onTap: () {}),
              CheckedPopupMenuItemGI(label: "Correcto", checked: true, onTap: () {})
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),

  - Con un IconButton
          PopupMenuGI(
            items: [
              PopupMenuHeaderGI(
                imageProvider: AssetImage(ImagesPath.empty_cart.path),
                label: "Mi perfil",
                onTap: () {}
              ),
              PopupMenuItemGI(icon: Icons.add, label: "Adicionar", onTap: () {}),
              PopupMenuDividerGI(height: 8),
              PopupMenuItemGI(label: "Borrar", onTap: () {}),
              CheckedPopupMenuItemGI(label: "Correcto", checked: true, onTap: () {})
            ],
            icon: Icons.add,
          ),
*/

class PopupMenuGI extends StatelessWidget {
  const PopupMenuGI({
    super.key,
    this.icon,
    this.child,
    required this.items,
  });

  final IconData? icon;
  final Widget? child;
  final List<AbstractPopupItemGI> items;

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _showPopupMenu(context, items);
              },
              child: child,
            ),
          ));
    }
    if (icon != null) {
      return CustomIconButton(
        icon: icon!,
        onPressed: () {
          _showPopupMenu(context, items);
        },
      );
    }
    return Container();
  }

  _showPopupMenu<T>(
      BuildContext context, List<AbstractPopupItemGI> items) async {
    Rect position = context.currentWidgetPosition!;
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
      position: RelativeRect.fromLTRB(
          position.left, position.top, position.right, position.bottom),
      items: items.map((e) => e.toPopupMenuEntry).toList(),
    );
  }
}

abstract class AbstractPopupItemGI {
  PopupMenuEntry get toPopupMenuEntry;
}

class PopupMenuHeaderGI extends AbstractPopupItemGI {
  final ImageProvider imageProvider;
  final String? label;
  final VoidCallback? onTap;
  PopupMenuHeaderGI({
    required this.imageProvider,
    this.label,
    this.onTap,
  });

  @override
  PopupMenuEntry get toPopupMenuEntry {
    Widget child = CircleAvatar(
      radius: 40,
        child: Image(
      image: imageProvider,
      width: 80,
      height: 80,
    ));
    if (label != null) {
      child = Column(
          mainAxisSize: MainAxisSize.min, children: [child, Text(label!)]);
    }
    return PopupMenuItem(
      enabled: onTap != null,
      onTap: onTap,
      child: SizedBox(
        height: label != null ? 120 : 100,
        child: Center(child: child),
      ),
    );
  }
}

class PopupMenuItemGI extends AbstractPopupItemGI {
  final IconData? icon;
  final String label;
  final VoidCallback? onTap;

  PopupMenuItemGI({
    this.icon,
    required this.label,
    this.onTap,
  });

  @override
  PopupMenuEntry get toPopupMenuEntry {
    Widget child = Text(label);
    if (icon != null) {
      child = Row(children: [Icon(icon), const SizedBox(width: 8), child]);
    }
    return PopupMenuItem(
      child: child,
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}

class PopupMenuDividerGI extends AbstractPopupItemGI {
  final double height;

  PopupMenuDividerGI({
    this.height = 16,
  });

  @override
  PopupMenuEntry get toPopupMenuEntry {
    return PopupMenuDivider(
      height: height,
    );
  }
}

class CheckedPopupMenuItemGI extends AbstractPopupItemGI {
  final IconData? icon;
  final String label;
  final bool checked;
  final VoidCallback? onTap;
  CheckedPopupMenuItemGI({
    this.icon,
    required this.label,
    this.checked = false,
    this.onTap,
  });

  @override
  PopupMenuEntry get toPopupMenuEntry {
    return CheckedPopupMenuItem(
      child: Text(label),
      checked: checked,
      enabled: onTap != null,
      onTap: onTap,
    );
  }
}
