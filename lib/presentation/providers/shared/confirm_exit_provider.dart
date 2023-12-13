import 'package:hooks_riverpod/hooks_riverpod.dart';

final confirmExitProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});