import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final transferProvider =
    StateNotifierProvider<TransferNotifier, TransferState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.watch(connectivityStatusProvider.notifier);

  return TransferNotifier(
      transferRemoteRepository: apiConsumer.transfer,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class TransferNotifier extends StateNotifier<TransferState> {
  final TransferRemoteRepository transferRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  TransferNotifier(
      {required this.transferRemoteRepository,
      required this.connectivityStatusNotifier})
      : super(TransferState()) {
    refresh();
  }

  TransferState get currentState => state;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await getListPaidAndUnpaidReceive();
    state = state.copyWith(isLoading: false);
  }

  Future<int> createReceive(double amount) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await transferRemoteRepository.createReceive(amount);
      getListPaidAndUnpaidReceive();
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<int> deleteUnpaidReceive(int id) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await transferRemoteRepository.deleteUnpaidReceive(id);
      getListPaidAndUnpaidReceive();
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<void> getListPaidAndUnpaidReceive() async {
    await getListPaidReceive();
    await getListUnpaidReceive();
  }

  Future<void> getListPaidReceive() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<Transaction> listPaidReceive =
          await transferRemoteRepository.getListPaidReceive();
      state = state.copyWith(listPaidReceive: listPaidReceive);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(listPaidReceive: []);
      }
    } catch (e) {}
  }

  Future<void> getListUnpaidReceive() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<Transaction> listUnpaidReceive =
          await transferRemoteRepository.getListUnpaidReceive();
      state = state.copyWith(listUnpaidReceive: listUnpaidReceive);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(listUnpaidReceive: []);
      }
    } catch (e) {}
  }

  Transaction? getTransaction(String id) {
    if (state.listPaidReceive.isEmpty && state.listUnpaidReceive.isEmpty)
      return null;
    for(Transaction t in state.listPaidReceive){
      if(t.id.toString() == id) {
        return t;
      }
    }
    for(Transaction t in state.listUnpaidReceive){
      if(t.id.toString() == id) {
        return t;
      }
    }
    return null;
  }
}

class TransferState {
  final bool isLoading;
  final List<Transaction> listPaidReceive;
  final List<Transaction> listUnpaidReceive;

  TransferState({
    this.isLoading = false,
    this.listPaidReceive = const [],
    this.listUnpaidReceive = const [],
  });

  TransferState copyWith({
    bool? isLoading,
    List<Transaction>? listPaidReceive,
    List<Transaction>? listUnpaidReceive,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      listPaidReceive: listPaidReceive ?? this.listPaidReceive,
      listUnpaidReceive: listUnpaidReceive ?? this.listUnpaidReceive,
    );
  }
}
