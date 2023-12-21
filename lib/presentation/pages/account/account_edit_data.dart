import 'package:flutter/material.dart';
import 'package:zona0_apk/main.dart';

class AccountEditData extends StatelessWidget {
  const AccountEditData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editarDatos),
      ),
    );
  }
}