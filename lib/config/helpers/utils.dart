import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    if(data == null) return "";
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    String cad = "";
    json.values.forEach((arr) => List<String>.from(arr).forEach((element) {
          if (cad.isNotEmpty) cad += "\n";
          cad += "- $element";
        }));
    return cad;
  }

  static String getErrorsFromXnon_field_errors(dynamic data) {
    if(data == null) return "";
    Map<String, dynamic> json = (data is String) ? jsonDecode(data) : data;
    String cad = "";
    if(json["non_field_errors"] != null){
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

  static Future<bool> checkedConection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        return true;
      } else if (connectivityResult == ConnectivityResult.ethernet) {
        // I am connected to a ethernet network.
        return true;
      } else if (connectivityResult == ConnectivityResult.vpn) {
        // I am connected to a vpn network.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
        return true;
      } else if (connectivityResult == ConnectivityResult.bluetooth) {
        // I am connected to a bluetooth.
        return true;
      } else if (connectivityResult == ConnectivityResult.other) {
        // I am connected to a network which is not in the above mentioned networks.
        return true;
      } else if (connectivityResult == ConnectivityResult.none) {
        // I am not connected to any network.
        return false;
      }
    } catch (e) {
      print("Error conection");
    }
    return false;
  }

  static List<CompanyType> get companyTypes => [
      CompanyType("Mipyme"),
      CompanyType("TCP"),
      CompanyType("Estatal")
    ];
}
