import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.text, required this.time, required this.monto});

  final String text;
  final String time;
  final double monto;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: color.secondaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
        ),
        child: Icon(monto < 0 ? Icons.trending_down_rounded : Icons.trending_up_rounded),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: Text(text, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 120,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
          ),
          child: Text('${monto.toStringAsFixed(2)} ${Constants.namePoints}',
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.secondary))),
    );
  }
}