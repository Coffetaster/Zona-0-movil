import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

import 'snackbar_gi.dart';

class Utils {
  static showSnackbarEnDesarrollo(BuildContext context) =>
      SnackBarGI.showWithIcon(context,
          icon: Icons.watch_later_outlined, text: "En desarrollo");

  static String getErrorsFromRegister(dynamic data) {
    if (data == null) return "";
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    String cad = "";
    json.values.forEach((arr) => List<String>.from(arr).forEach((element) {
          if (cad.isNotEmpty) cad += "\n";
          cad += "- $element";
        }));
    return cad;
  }

  static String getErrorsFromXnon_field_errors(dynamic data) {
    if (data == null) return "";
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    String cad = "";
    if (json["non_field_errors"] != null) {
      List<String>.from(json["non_field_errors"]).forEach((element) {
        if (cad.isNotEmpty) cad += "\n";
        cad += "- $element";
      });
    }
    return cad;
  }

  static void showDialogConfirmSalir(
      BuildContext context, WidgetRef ref, String idConfirmExitProvider) {
    DialogGI.showAlertDialog(context,
        title: AppLocalizations.of(context)!.salir,
        content: AppLocalizations.of(context)!.salirContent, actionOk: () {
      ref.read(confirmExitProvider(idConfirmExitProvider).notifier).state = 1;
    });
  }

  static List<CompanyType> get companyTypes =>
      [CompanyType("Mipyme"), CompanyType("TCP"), CompanyType("Estatal")];

  static Future<String?> selectAndCropImage(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      String? imagePath = await context.push(RouterPath.UTILS_IMAGE_CROP_PAGE,
          extra: image.path);
      return imagePath;
    }
    return null;
  }
}
