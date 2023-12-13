import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class NoLoginPage extends StatelessWidget {
  const NoLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NoLoginAlert()
        ],
      ),
    );
  }
}