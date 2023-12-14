import 'package:flutter/material.dart';

import 'snackbar_gi.dart';

class Utils {
  static showSnackbarEnDesarrollo(BuildContext context) =>
    SnackBarGI.showWithIcon(context, icon: Icons.watch_later_outlined, text: "En desarrollo");
}