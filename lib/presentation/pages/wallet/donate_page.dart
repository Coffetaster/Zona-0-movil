import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/images_path.dart';

import 'package:zona0_apk/domain/entities/donation.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Delete donations
    List<Donation> donations = [];
    donations.add(Donation(
        id: 1,
        name: "Lugar de anciano",
        aboutUs:
            "Esse cillum esse labore aliquip officia pariatur aliquip velit irure consequat ex deserunt in.",
        img1: ImagesPath.empty_cart.path,
        img2: ImagesPath.happy_birthday.path,
        img3: ImagesPath.new_notifications.path,
        img4: ImagesPath.under_construction.path,
      ));
    donations.add(Donation(
        id: 2,
        name: "Hogar materno",
        aboutUs:
            "Esse fugiat aliquip proident anim ipsum cupidatat tempor mollit.",
        img1: ImagesPath.pic_profile.path,
        img2: ImagesPath.logo.path,
        img3: ImagesPath.under_construction.path,
        img4: ImagesPath.new_notifications.path,
      ));
    donations.add(Donation(
        id: 3,
        name: "Casa de la patria",
        aboutUs:
            "Amet amet magna ad est sint magna ad id cillum dolore aliqua ex.",
        img1: "assets/imagen/b1.jpg",
        img2: "assets/imagen/b2.jpg",
        img3: "assets/imagen/b3.jpg",
        img4: "assets/imagen/b4.jpg",
      ));
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.donar),
        centerTitle: false,
      ),
      body: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: DonateItem(donation: donations[index]),
              );
            },),
        ),
      ),
    );
  }
}
