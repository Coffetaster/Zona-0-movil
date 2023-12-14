import 'package:hooks_riverpod/hooks_riverpod.dart';

final countdownTimerProvider = StateNotifierProvider.family.autoDispose<CountdownTimerNotifier, bool, String>((ref, id) {
  return CountdownTimerNotifier();
});

class CountdownTimerNotifier extends StateNotifier<bool> {
  CountdownTimerNotifier(): super(true);

  final int _cantSeconds = 90;
  int get endTime => DateTime.now().millisecondsSinceEpoch + 1000 * _cantSeconds;

  void set setState(bool newState) {
    state = newState;
  }
}