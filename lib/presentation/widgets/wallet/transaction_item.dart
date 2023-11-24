import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.text, required this.time, required this.monto});

  final String text;
  final String time;
  final double monto;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
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
            color: AppTheme.perfectGrey,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text('${monto.toStringAsFixed(2)} ZOP',
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff2c405b)))),
    );
  }
}