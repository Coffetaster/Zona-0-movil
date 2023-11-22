import 'dart:ui';

import 'package:zona0_apk/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier,LocaleState>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<LocaleState> {
  LocaleNotifier(): super(LocaleState());

  void setLocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    state = state.copyWith(locale: locale);
  }

  // void clearLocale() {
  //   state = state.copyWith(locale: null);
  // }
}

class LocaleState {

  /*
  Si se deja null la aplicación toma el idioma por defecto del sistema
  */

  final Locale locale;

  LocaleState({
    this.locale = const Locale("es")
  });

  LocaleState copyWith({
    Locale? locale,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}
