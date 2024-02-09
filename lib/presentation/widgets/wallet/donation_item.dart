import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/router/router_nav/router_nav.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

class DonationItem extends StatelessWidget {
  const DonationItem({
    Key? key,
    required this.donation,
    this.canTap = true,
  }) : super(key: key);

  final Donation donation;
  final bool canTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Consumer(
        builder: (context, ref, child) => ListTile(
              contentPadding: const EdgeInsets.symmetric(),
              title: Text(donation.institution,
                  style: Theme.of(context).textTheme.titleMedium, maxLines: 2),
              trailing: Container(
                  height: 30,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.secondaryContainer,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppTheme.borderRadius)),
                  ),
                  child: Text(
                      '${donation.amount.toStringAsFixed(2)} ${Constants.namePoints}',
                      maxLines: 1,
                      style: GoogleFonts.mulish(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color.secondary))),
              onTap: canTap
                  ? () {
                      Institution? institution;
                      final institutionsList =
                          ref.read(institutionsProvider).institutionsList;
                      for (Institution i in institutionsList) {
                        if (i.institution_name == donation.institution) {
                          institution = i;
                          break;
                        }
                      }
                      if (institution != null) {
                        context.nav.InstitutionDetailsPage(institution).push;
                      }
                    }
                  : null,
            ));
  }
}
