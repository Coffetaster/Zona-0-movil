import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
  Modo de uso:
    - Instalar la librería: connectivity_plus

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


    - También saber el tipo de conexión con
    connectivityStatusNotifier.currentState.connectivityResult
    o
    connectivityStatusNotifier.connectivityResult
    Nota: debes entrar a la clase ConnectivityResult para saber el tipo de conexión
*/

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatusState>(
        (ref) {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier
    extends StateNotifier<ConnectivityStatusState> {
  ConnectivityStatusNotifier() : super(ConnectivityStatusState()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  ConnectivityStatusState get currentState => state;
  bool get isConnected => state.isConnected;
  ConnectivityResult get connectivityResult => state.connectivityResult;

  Future<void> _updateConnectionStatus(
      ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.none) {
      if (state.isConnected) {
        state = state.copyWith(
            isConnected: false, connectivityResult: ConnectivityResult.none);
      }
    } else {
      final hasConnection = await _checkedConnection();
      if (hasConnection) {
        if (!state.isConnected ||
            state.connectivityResult != connectivityResult) {
          state = state.copyWith(
              isConnected: true, connectivityResult: connectivityResult);
        }
      } else {
        state = state.copyWith(
            isConnected: false, connectivityResult: ConnectivityResult.none);
      }
    }
  }

  Future<bool> _checkedConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {}
    return false;
  }
}

class ConnectivityStatusState {
  final bool isConnected;
  final ConnectivityResult connectivityResult;

  ConnectivityStatusState({
    this.isConnected = false,
    this.connectivityResult = ConnectivityResult.none,
  });

  ConnectivityStatusState copyWith({
    bool? isConnected,
    ConnectivityResult? connectivityResult,
  }) {
    return ConnectivityStatusState(
      isConnected: isConnected ?? this.isConnected,
      connectivityResult: connectivityResult ?? this.connectivityResult,
    );
  }
}
