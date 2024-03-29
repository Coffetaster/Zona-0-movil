import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/main.dart';

class PlayGamePage extends StatelessWidget {
  const PlayGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.juegos),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Utils.underConstructionImage()
                ]),
          ),
        ),
      ),
    );
  }
}