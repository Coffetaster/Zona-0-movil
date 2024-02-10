import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/banking/banking_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DepositItem extends StatelessWidget {
  const DepositItem({super.key, required this.deposit});

  final Deposit deposit;
  @override
  Widget build(BuildContext context) {
  final diasRestantes = 30 - (deposit.date_banked % 30);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: context.primary.withOpacity(.1),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              deposit.date,
              style: context.titleSmall,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 10,
              decoration: BoxDecoration(
                  color: context.primary.withOpacity(.5),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppTheme.borderRadius))),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Ganancia mensual",
                  style: context.labelLarge,
                ),
                Text("3%"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Monto inicial",
                  style: context.labelLarge,
                ),
                Text("${deposit.amount.toStringAsFixed(2)} OSP"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Monto actual",
                  style: context.labelLarge,
                ),
                Text(
                    "${(deposit.amount + deposit.interest).toStringAsFixed(2)} OSP"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Ganancia en ${diasRestantes} ${diasRestantes == 1 ? "día" : "días"}",
                  style: context.labelLarge,
                ),
                Text(
                    "${(deposit.amount + deposit.post_interest).toStringAsFixed(2)} OSP"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Tiempo transcurrido",
                  style: context.labelLarge,
                ),
                Text(
                    "${deposit.date_banked} ${deposit.date_banked > 1 ? "días" : "día"}"),
              ],
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                return CustomFilledButton(
                  label: "Retirar",
                  onPressed: deposit.canRetired
                      ? () async {
                          bool isOpenDialog = true;
                          Utils.showDialogIsLoading(context)
                              .then((value) => isOpenDialog = false);
                          final code = await ref
                              .read(bankingProvider.notifier)
                              .withdrawDeposit(deposit.id.toString());
                          if (isOpenDialog) {
                            context.pop();
                          }
                          if (code != "200") {
                            switch (code) {
                              case "412":
                                SnackBarGI.showWithIcon(context,
                                    icon: Icons.error_outline,
                                    text: AppLocalizations.of(context)!
                                        .camposConError);
                                break;
                              case "498":
                                SnackBarGI.showWithIcon(context,
                                    icon: Icons.error_outline,
                                    text: AppLocalizations.of(context)!
                                        .compruebeConexion);
                                break;
                              default:
                                SnackBarGI.showWithIcon(context,
                                    icon: Icons.error_outline,
                                    text: code.isEmpty
                                        ? AppLocalizations.of(context)!
                                            .haOcurridoError
                                        : code);
                            }
                          }
                        }
                      : null,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
