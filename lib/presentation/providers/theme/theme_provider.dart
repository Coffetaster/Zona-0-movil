import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zona0_apk/domain/shared_preferences/my_shared.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier,ThemeState>((ref) {
  return ThemeNotifier(ref.read(mySharedProvider));
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this.myShared): super(ThemeState()){
    init();
  }
  final MyShared myShared;

  Future<void> init() async {
    final isDark = await myShared.getValueNoNull<bool>(MySharedConstants.isDarkTheme);
    state = state.copyWith(
      isDark: isDark
    );
  }

  Future<void> toggleDark() async {
    final isDark = !state.isDark;
    myShared.setKeyValue<bool>(MySharedConstants.isDarkTheme, isDark);
    state = state.copyWith(
      isDark: isDark
    );
  }
}

class ThemeState {
  final bool isDark;

  ThemeState({
    this.isDark = false
  });

  ThemeState copyWith({
    bool? isDark,
  }) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }
}
