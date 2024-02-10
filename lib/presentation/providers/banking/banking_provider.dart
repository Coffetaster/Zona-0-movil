import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/helpers/utils.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final bankingProvider =
    StateNotifierProvider.autoDispose<BankingNotifier, BankingState>(
        (ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return BankingNotifier(
      bankingRemoteRepository: apiConsumer.banking,
      connectivityStatusNotifier: connectivityStatusNotifier,
      getOSPPoints: ref.read(accountProvider.notifier).getOSPPoints);
});

class BankingNotifier extends StateNotifier<BankingState> {
  final BankingRemoteRepository bankingRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;
  final Function() getOSPPoints;

  BankingNotifier({
    required this.bankingRemoteRepository,
    required this.connectivityStatusNotifier,
    required this.getOSPPoints,
  }) : super(BankingState()) {
    refresh();
  }

  BankingState get currentState => state;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await getDeposits();
    state = state.copyWith(isLoading: false);
  }

  Future<int> createDeposit(double amount) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await bankingRemoteRepository.createDeposit(amount);
      getDeposits();
      getOSPPoints();
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> getDeposits() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<Deposit> deposits =
          await bankingRemoteRepository.getDeposits();
      state = state.copyWith(deposits: deposits);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(deposits: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<String> withdrawDeposit(String idAccount) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return "498";
      }
      await bankingRemoteRepository.withdrawDeposit(idAccount);
      getDeposits();
      getOSPPoints();
      return "200";
    } on CustomDioError catch (e) {
      connectivityStatusNotifier.checkedConnection();
      return Utils.getErrorsFromDioException(e.data);
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
    }
    return "";
  }

  Future<Deposit> getDeposit(String idDeposit) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        throw CustomDioError(code: 498);
      }
      Deposit deposit = await bankingRemoteRepository.getDeposit(idDeposit);
      return deposit;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }
}

class BankingState {
  final bool isLoading;
  final List<Deposit> deposits;
  BankingState({
    this.isLoading = false,
    this.deposits = const [],
  });

  BankingState copyWith({
    bool? isLoading,
    List<Deposit>? deposits,
  }) {
    return BankingState(
      isLoading: isLoading ?? this.isLoading,
      deposits: deposits ?? this.deposits,
    );
  }
}
