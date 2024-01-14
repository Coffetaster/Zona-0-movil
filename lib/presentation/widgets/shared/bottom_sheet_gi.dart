import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class BottomSheetGI {
  static void showCustom({
    required BuildContext context,
    required child,
    double borderRadius = AppTheme.borderRadius,
    Color? backgroundColor,
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: backgroundColor,
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(borderRadius)),
        ),
        builder: (_) => child);
  }

  static void showConfirm({
    required BuildContext context,
    required title,
    required content,
    String textActionOk = "Aceptar",
    String textActionCancel = "Cancelar",
    VoidCallback? actionOk,
    VoidCallback? actionCancel,
    Widget? btnOk,
    Widget? btnCancel,
    bool hasCancelBtn = true,
    Color? backgroundColor,
    bool isDismissible = true,
  }) {
    dismissDialog() => context.pop();
    // dismissDialog()=> Navigator.of(context, rootNavigator: true).pop();
    actionOk ??= dismissDialog;
    actionCancel ??= dismissDialog;
    // actionOk = actionOk == null ? dismissDialog : () {
    //   actionOk!();
    //   // Future.delayed(const Duration(milliseconds: 300), () => actionOk!());
    //   // dismissDialog();
    // };
    // actionCancel = actionCancel == null ? dismissDialog : () {
    //   dismissDialog();
    //   actionCancel!();
    // };
    btnOk ??= CustomFilledButton(onPressed: actionOk, label: textActionOk);
    btnCancel ??=
        CustomTextButton(onPressed: actionCancel, label: textActionCancel);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: backgroundColor,
        isDismissible: isDismissible,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppTheme.borderRadius)),
        ),
        builder: (_) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: context.titleLarge),
                  const SizedBox(height: 8),
                  Text(content,
                      style: context.bodyMedium, textAlign: TextAlign.justify),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [if (hasCancelBtn) btnCancel!, btnOk!],
                  )
                ],
              ),
            ));
  }
}
