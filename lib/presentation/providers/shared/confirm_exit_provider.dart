import 'package:hooks_riverpod/hooks_riverpod.dart';

final confirmExitProvider = StateProvider.autoDispose.family<int,String>((ref, id) {
  /*
  0 - pedir confirmación
  1 - salir
  2 - puede moverse a otra pantalla
  */
  return 0;
});