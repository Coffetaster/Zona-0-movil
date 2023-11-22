import 'package:zona0_apk/l10n/l10n.dart';
import 'package:zona0_apk/presentation/providers/language/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagePicker extends ConsumerWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final localeFinal = ref.watch(localeProvider);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: localeFinal.locale,
        icon: Container(width: 12),
        items: L10n.all.map(
          (locale) {
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Center(child: Text(flag, style: TextStyle(fontSize: 32))),
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(locale);
              },
            );
          }
        ).toList(),
        onChanged: (value) {},
      ),
    );
  }
}