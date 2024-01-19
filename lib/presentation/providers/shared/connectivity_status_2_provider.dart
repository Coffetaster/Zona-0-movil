/*
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/*
  Modo de uso:
    - Instalar la librería: internet_connection_checker_plus

    - En otro provider obtén el notifier
    final connectivityStatusNotifier = ref.watch(connectivityStatusProvider.notifier);

    - En el constructor del notifier de ese provider puedes usar
    connectivityStatusNotifier.addListener((connectivityStatusState) {
      print("Hay conexión: ${connectivityStatusState.isConnected ? "si" : "no"}");
      if (connectivityStatusState.isConnected) {
        // is connected
      } else {
        // connection lost
      }
    });

    - En cualquier parte del provider puedes saber si hay conexión a internet usando
    connectivityStatusNotifier.currentState.isConnected
    o
    connectivityStatusNotifier.isConnected
*/

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatusState>(
        (ref) {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier
    extends StateNotifier<ConnectivityStatusState> {
  ConnectivityStatusNotifier() : super(ConnectivityStatusState()) {
    _internetStatusSubscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          state = state.copyWith(isConnected: true);
          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          state = state.copyWith(isConnected: false);
          break;
      }
    });
  }

  late StreamSubscription<InternetStatus> _internetStatusSubscription;

  @override
  void dispose() {
    _internetStatusSubscription.cancel();
    super.dispose();
  }

  ConnectivityStatusState get currentState => state;
  bool get isConnected => state.isConnected;
}

class ConnectivityStatusState {
  final bool isConnected;

  ConnectivityStatusState({
    this.isConnected = false,
  });

  ConnectivityStatusState copyWith({
    bool? isConnected,
  }) {
    return ConnectivityStatusState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
*/