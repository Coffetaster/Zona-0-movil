import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

class TransactionSentItem extends StatelessWidget {
  const TransactionSentItem({super.key, required this.transaction});

  final TransactionSent transaction;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: Text(transaction.receiveUser,
          style: Theme.of(context).textTheme.titleMedium, maxLines: 2),
      subtitle: Text("${transaction.date}, ${transaction.time.split(".")[0]}",
          maxLines: 1),
      trailing: Container(
          height: 30,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.secondaryContainer,
            borderRadius:
                const BorderRadius.all(const Radius.circular(AppTheme.borderRadius)),
          ),
          child: Text(
              '${transaction.amount.toStringAsFixed(2)} ${Constants.namePoints}',
              maxLines: 1,
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.secondary))),
    );
  }
}
