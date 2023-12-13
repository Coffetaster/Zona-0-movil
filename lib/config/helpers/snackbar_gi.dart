import 'package:flutter/material.dart';

class SnackbarGI {
  static void show(BuildContext context, {
    required String text,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
  }){
    if(text.isEmpty) return;
    final snackbar = SnackBar(
      content: Text(text),
      action: action,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackbar);
  }

  static void showWithIcon(BuildContext context, {
    required IconData icon,
    required String text,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
  }){
    if(text.isEmpty) return;
    final snackbar = SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(text),
          ],
        ),
      ),
      action: action,
      duration: duration,
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackbar);
  }
}