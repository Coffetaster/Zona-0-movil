import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

class CardDiscountItem extends StatelessWidget {
  const CardDiscountItem({super.key, required this.cardDiscount, required this.isOwn});

  final CardDiscount cardDiscount;
  final bool isOwn;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: Text(isOwn ? "A ${cardDiscount.user}" : "De ${cardDiscount.user}",
          style: Theme.of(context).textTheme.titleMedium, maxLines: 1),
      subtitle: Text("${cardDiscount.date}, ${cardDiscount.time.split(".")[0]}",
          maxLines: 1),
      trailing: Container(
          height: 30,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.secondaryContainer,
            borderRadius: const BorderRadius.all(
                const Radius.circular(AppTheme.borderRadius)),
          ),
          child: Text(
              '${cardDiscount.amount.toStringAsFixed(2)} ${Constants.namePoints}',
              maxLines: 1,
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.secondary))),
    );
  }
}
