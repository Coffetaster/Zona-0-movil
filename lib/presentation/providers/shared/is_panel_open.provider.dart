import 'package:hooks_riverpod/hooks_riverpod.dart';

final isPanelOpenProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});