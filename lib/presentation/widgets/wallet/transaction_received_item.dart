import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

class TransactionReceivedItem extends StatelessWidget {
  const TransactionReceivedItem(
      {super.key, required this.transaction, this.canEdit = true});

  final TransactionReceived transaction;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: Text(transaction.code,
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
                BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
          ),
          child: Text(
              '${transaction.amount.toStringAsFixed(2)} ${Constants.namePoints}',
              maxLines: 1,
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.secondary))),
      onTap: () => context.push(
          RouterPath.WALLET_RECEIVE_ITEM_DATA_PAGE(
              transaction.id.toString(), canEdit),
          extra: transaction),
    );
  }
}
