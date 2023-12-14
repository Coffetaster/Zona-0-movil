import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

import 'snackbar_gi.dart';

class Utils {
  static showSnackbarEnDesarrollo(BuildContext context) =>
      SnackBarGI.showWithIcon(context,
          icon: Icons.watch_later_outlined, text: "En desarrollo");

  static String getErrorsFromRegister(dynamic data) {
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    String cad = "";
    json.values.forEach((arr) => List<String>.from(arr).forEach((element) {
          if (cad.isNotEmpty) cad += "\n";
          cad += "- $element";
        }));
    return cad;
  }

  static void showDialogConfirmSalir(BuildContext context, WidgetRef ref, String idConfirmExitProvider) {
    DialogGI.showAlertDialog(context,
        title: AppLocalizations.of(context)!.salir,
        content: AppLocalizations.of(context)!.salirContent, actionOk: () {
      ref.read(confirmExitProvider(idConfirmExitProvider).notifier).state = 1;
    });
  }
}
