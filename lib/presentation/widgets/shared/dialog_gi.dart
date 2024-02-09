import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DialogGI {
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
    bool isDismissible = true,
    Color barrierColor = Colors.black54,
    String textActionOk = "Aceptar",
    String textActionCancel = "Cancelar",
    VoidCallback? actionOk,
    VoidCallback? actionCancel,
    Widget? btnOk,
    Widget? btnCancel,
    bool hasCancelBtn = true,
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
    showDialog(
        context: context,
        barrierColor: barrierColor,
        barrierDismissible: isDismissible,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
              elevation: 5,
              title: Text(title),
              content: Text(content),
              actions: [if (hasCancelBtn) btnCancel!, btnOk!],
            ));
  }

  static void showCustomDialog(BuildContext context,
      {required Widget dialog,
      bool isDismissible = true,
      Color barrierColor = Colors.black54}) {
    showDialog(
        context: context,
        barrierColor: barrierColor,
        barrierDismissible: isDismissible,
        builder: (context) => Center(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: context.width * .6,
                      maxWidth: context.width * .8,
                      minHeight: context.height * .3,
                      maxHeight: context.height * .8,
                      ),
                  child: CustomCard(elevation: 5, child: dialog)),
            ));
  }
}
