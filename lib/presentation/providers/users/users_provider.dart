import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final usersProvider =
    StateNotifierProvider.autoDispose<UsersNotifier, UsersState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final accountNotifier = ref.read(accountProvider.notifier);
  final connectivityStatusNotifier =
      ref.watch(connectivityStatusProvider.notifier);

  return UsersNotifier(
      usersRemoteRepository: apiConsumer.users,
      accountNotifier: accountNotifier,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class UsersNotifier extends StateNotifier<UsersState> {
  final UsersRemoteRepository usersRemoteRepository;
  final AccountNotifier accountNotifier;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  UsersNotifier(
      {required this.usersRemoteRepository,
      required this.accountNotifier,
      required this.connectivityStatusNotifier})
      : super(UsersState()){
        waitingGetMyData();
      }

  UsersState get currentState => state;

  Future<void> waitingGetMyData() async {
    try {
      state = state.copyWith(isLoading: true);
      await getMyData();
    } on CustomDioError catch (_) {}
    state = state.copyWith(isLoading: false);
  }

  Future<void> getMyData() async {
    try {
      if (accountNotifier.state.isClient) {
        await _getMyDataClient();
      } else if (accountNotifier.state.isCompany) {
        await _getMyDataCompany();
      }
    } on CustomDioError catch (_) {}
  }

  Future<int> _getMyDataClient() async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      final client = await usersRemoteRepository.getMyDataClient();
      if (client != null) {
        state = state.copyWith(client: () => client, company: () => null);
      }
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<dynamic> updateDataClient(Client client) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await usersRemoteRepository.updateDataClient(client);
      accountNotifier.updateDataUserOfClient(client);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<int> _getMyDataCompany() async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      final company = await usersRemoteRepository.getMyDataCompany();
      if (company != null) {
        state = state.copyWith(client: () => null, company: () => company);
      }
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<dynamic> updateDataCompany(Company company) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await usersRemoteRepository.updateDataCompany(company);
      accountNotifier.updateDataUserOfCompany(company);
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

class UsersState {
  final bool isLoading;
  final Client? client;
  final Company? company;
  UsersState({
    this.isLoading = false,
    this.client,
    this.company,
  });

  UsersState copyWith({
    bool? isLoading,
    ValueGetter<Client?>? client,
    ValueGetter<Company?>? company,
  }) {
    return UsersState(
      isLoading: isLoading ?? this.isLoading,
      client: client != null ? client() : this.client,
      company: company != null ? company() : this.company,
    );
  }
}
