import 'package:flutter/material.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/donation.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';

class DonateItem extends StatelessWidget {
  const DonateItem({super.key, required this.donation});

  final Donation donation;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                          width: double.infinity,
                          height: 185,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.borderRadius),
                                child: Image.asset(donation.img1,
                                    fit: BoxFit.cover)),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.borderRadius),
                              child: Image.asset(
                                donation.img2,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.borderRadius),
                              child: Image.asset(
                                donation.img3,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.borderRadius),
                              child: Image.asset(
                                donation.img4,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(donation.name, style: context.titleLarge),
                  CustomOutlinedButton(
                      label: AppLocalizations.of(context)!.visitar,
                      onPressed: () {
                        Utils.showSnackbarEnDesarrollo(context);
                      })
                ],
              )),
            ],
          )),
    );
  }
}
