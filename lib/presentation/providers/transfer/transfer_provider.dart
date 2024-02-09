import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final transferProvider =
    StateNotifierProvider.autoDispose<TransferNotifier, TransferState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);
  final institutionsNotifier = ref.read(institutionsProvider.notifier);

  return TransferNotifier(
      transferRemoteRepository: apiConsumer.transfer,
      connectivityStatusNotifier: connectivityStatusNotifier,
      institutionsNotifier: institutionsNotifier,
      getOSPPoints: ref.read(accountProvider.notifier).getOSPPoints);
});

class TransferNotifier extends StateNotifier<TransferState> {
  final TransferRemoteRepository transferRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;
  final InstitutionsNotifier institutionsNotifier;
  final Function() getOSPPoints;

  TransferNotifier({
    required this.transferRemoteRepository,
    required this.connectivityStatusNotifier,
    required this.institutionsNotifier,
    required this.getOSPPoints,
  }) : super(TransferState()) {
    institutionsNotifier.addListener((institutionsState) {
      state = state.copyWith(
        donationsList: institutionsState.donationsList,
      );
    });
    refresh();
  }

  TransferState get currentState => state;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await getAllTransactions();
    state = state.copyWith(isLoading: false);
  }

  Future<int> createReceive(double amount,
      {Function(TransactionReceived transaction)? callback}) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      TransactionReceived transaction =
          await transferRemoteRepository.createReceive(amount);
      if (callback != null) {
        await getListUnpaidReceive();
        callback(transaction);
        getListPaidReceive();
      } else {
        getListPaidAndUnpaidReceive();
      }
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

  Future<int> createSend(String code) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await transferRemoteRepository.createSend(code);
      getListSendTransfer();
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

  Future<TransactionReceived> getReceive(String code) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        throw CustomDioError(code: 498);
      }
      TransactionReceived transaction =
          await transferRemoteRepository.getReceive(code);
      return transaction;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<int> deleteUnpaidReceive(int id) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await transferRemoteRepository.deleteUnpaidReceive(id);
      Future.delayed(
        const Duration(milliseconds: 600),
        () {
          state = state.copyWith(
              listUnpaidReceive: state.listUnpaidReceive
                ..removeWhere((t) => t.id == id));
          getListPaidAndUnpaidReceive();
        },
      );
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

  Future<void> getListSendTransfer() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<TransactionSent> listTransactionsSent =
          await transferRemoteRepository.getListSendTransfer();
      state = state.copyWith(listTransactionsSent: listTransactionsSent);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(listTransactionsSent: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<void> getAllTransactions() async {
    await getListPaidAndUnpaidReceive();
    await getListSendTransfer();
    await institutionsNotifier.getDonations();
    getOSPPoints();
  }

  Future<void> getListPaidAndUnpaidReceive() async {
    await getListPaidReceive();
    await getListUnpaidReceive();
  }

  Future<void> getListPaidReceive() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<TransactionReceived> listPaidReceive =
          await transferRemoteRepository.getListPaidReceive();
      state = state.copyWith(listPaidReceive: listPaidReceive);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(listPaidReceive: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<void> getListUnpaidReceive() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<TransactionReceived> listUnpaidReceive =
          await transferRemoteRepository.getListUnpaidReceive();
      state = state.copyWith(listUnpaidReceive: listUnpaidReceive);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(listUnpaidReceive: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  TransactionReceived? getTransaction(String id) {
    if (state.listPaidReceive.isEmpty && state.listUnpaidReceive.isEmpty)
      return null;
    for (TransactionReceived t in state.listPaidReceive) {
      if (t.id.toString() == id) {
        return t;
      }
    }
    for (TransactionReceived t in state.listUnpaidReceive) {
      if (t.id.toString() == id) {
        return t;
      }
    }
    return null;
  }

  Future<void> getDonations() async {
    await institutionsNotifier.getDonations();
  }
}

class TransferState {
  final bool isLoading;
  final List<TransactionReceived> listPaidReceive;
  final List<TransactionReceived> listUnpaidReceive;
  final List<TransactionSent> listTransactionsSent;
  final List<Donation> donationsList;

  TransferState({
    this.isLoading = false,
    this.listPaidReceive = const [],
    this.listUnpaidReceive = const [],
    this.listTransactionsSent = const [],
    this.donationsList = const [],
  });

  TransferState copyWith({
    bool? isLoading,
    List<TransactionReceived>? listPaidReceive,
    List<TransactionReceived>? listUnpaidReceive,
    List<TransactionSent>? listTransactionsSent,
    List<Donation>? donationsList,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      listPaidReceive: listPaidReceive ?? this.listPaidReceive,
      listUnpaidReceive: listUnpaidReceive ?? this.listUnpaidReceive,
      listTransactionsSent: listTransactionsSent ?? this.listTransactionsSent,
      donationsList: donationsList ?? this.donationsList,
    );
  }
}
