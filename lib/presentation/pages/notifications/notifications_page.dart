import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/main.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notificaciones),
      ),
      body: NoNotifications(size),
    );
  }

  Widget NoNotifications(Size size) => ZoomIn(
      child: Center(
          child: Image.asset(ImagesPath.new_notifications.path,
              width: size.width * .75,
              height: size.width * .75,
              fit: BoxFit.contain)));
}
