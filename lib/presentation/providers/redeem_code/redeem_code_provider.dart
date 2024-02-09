import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final redeemCodeProvider =
    StateNotifierProvider.autoDispose<RedeemCodeNotifier, RedeemCodeState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return RedeemCodeNotifier(
      redeemCodeRemoteRepository: apiConsumer.redeemCode,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class RedeemCodeNotifier extends StateNotifier<RedeemCodeState> {
  final RedeemCodeRemoteRepository redeemCodeRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  RedeemCodeNotifier(
      {required this.redeemCodeRemoteRepository,
      required this.connectivityStatusNotifier})
      : super(RedeemCodeState());

  RedeemCodeState get currentState => state;

  Future<int> redeem(String code) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await redeemCodeRemoteRepository.redeem(code);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }
}

class RedeemCodeState {

  RedeemCodeState();
}
