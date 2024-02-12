import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

import 'snackbar_gi.dart';

typedef LoadingFunction = Future<void> Function();

class Utils {
  static Future<void> waitingLoading(BuildContext context, LoadingFunction loadingFunction) async {
    bool isOpenDialog = true;
    showDialogIsLoading(context).then((value) => isOpenDialog = false);
    await loadingFunction();
    if(isOpenDialog){
      context.pop();
    }
  }

  static Future showDialogIsLoading(BuildContext context) =>
      DialogGI.showCustomDialog(context,
          isDismissible: false, dialog: const DialogIsLoading());

  static showSnackbarEnDesarrollo(BuildContext context) =>
      SnackBarGI.showWithIcon(context,
          icon: Icons.watch_later_outlined, text: "En desarrollo");

  static showSnackbarCompruebeConexion(BuildContext context) =>
      SnackBarGI.showWithIcon(context,
          icon: Icons.error_outline,
          text: AppLocalizations.of(context)!.compruebeConexion);

  static showSnackbarHaOcurridoError(BuildContext context) =>
      SnackBarGI.showWithIcon(context,
          icon: Icons.error_outline,
          text: AppLocalizations.of(context)!.haOcurridoError);

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

  static String getErrorsFromDioException(dynamic data,
      [String defaultError = ""]) {
    if (data == null) return defaultError;
    try {
      Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
      if (json["message"] != null) {
        return json["message"];
      }
      if (json["error"] != null) {
        return json["error"];
      }
      if (json["non_field_errors"] != null) {
        String cad = "";
        List<String>.from(json["non_field_errors"]).forEach((element) {
          if (cad.isNotEmpty) cad += "\n";
          cad += "- $element";
        });
        return cad;
      }
    } catch (_) {}
    return defaultError;
  }

  static String getErrorsFromUpdateClientAndCompany(dynamic data) {
    if (data == null) return "";
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    if (json["errors"] != null) {
      String cad = "";
      Map<String, dynamic> errors = json["errors"];
      errors.values.forEach((element) {
        if (element is List) {
          (element as List).forEach((element2) {
            if (cad.isNotEmpty) cad += "\n";
            cad += "- $element2";
          });
        } else {
          if (cad.isNotEmpty) cad += "\n";
          cad += "- $element";
        }
      });
      return cad;
    }
    if (json["message"] != null) {
      return json["message"];
    }
    return "";
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

  static Widget underConstructionImage({
    double width = 200,
    double height = 200,
  }) =>
      SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(ImagesPath.under_construction.path,
                width: width, height: height),
            const Text("En desarrollo")
          ],
        ),
      );

  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String> pasteFromClipboard() async {
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? "";
    // return clipboardData != null ? clipboardData.text ?? "" : "";
  }

  static double calcInterest(double amount, int days) =>
      (amount * (days / 30) * (3 / 100)) + amount;

  static void parseErrorCode(BuildContext context, String code) {
    switch (code) {
      case "412":
        SnackBarGI.showWithIcon(context,
            icon: Icons.error_outline,
            text: AppLocalizations.of(context)!.camposConError);
        break;
      case "498":
        SnackBarGI.showWithIcon(context,
            icon: Icons.error_outline,
            text: AppLocalizations.of(context)!.compruebeConexion);
        break;
      default:
        SnackBarGI.showWithIcon(context,
            icon: Icons.error_outline,
            text: code.isEmpty
                ? AppLocalizations.of(context)!.haOcurridoError
                : code);
    }
  }
}
