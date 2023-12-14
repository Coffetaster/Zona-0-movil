import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';

import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';
import 'package:zona0_apk/domain/shared_preferences/my_shared.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';

final accountProvider =
    StateNotifierProvider<RegisterNotifier, AccountsState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final myShared = ref.read(mySharedProvider);

  return RegisterNotifier(
      accountsRemoteRepository: apiConsumer.accounts, myShared: myShared);
});

class RegisterNotifier extends StateNotifier<AccountsState> {
  final MyShared myShared;
  final AccountsRemoteRepository accountsRemoteRepository;

  RegisterNotifier(
      {required this.accountsRemoteRepository, required this.myShared})
      : super(AccountsState()) {}

  AccountsState get currentState => state;

  Future<int> login({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await accountsRemoteRepository.login(
          username: username,
          email: email,
          password: password,
          loginCallback: (String token, Client? client, Company? company) {
            print("entro");
          });
      return 200;
    } on CustomDioError catch (e) {
      return e.code;
    } catch (e) {}
    return 400;
  }

}

enum AccountStatus { checking, authenticated, notAuthenticated }

class AccountsState {
  final AccountStatus authStatus;
  final Client? client;
  final Company? company;
  final String errorMessage;
  final int errorCode;

  AccountsState(
      {this.authStatus = AccountStatus.checking,
      this.client,
      this.company,
      this.errorMessage = '',
      this.errorCode = 400});

  AccountsState copyWith({
    AccountStatus? authStatus,
    ValueGetter<Client?>? client,
    ValueGetter<Company?>? company,
    String? errorMessage,
    int? errorCode,
  }) {
    return AccountsState(
      authStatus: authStatus ?? this.authStatus,
      client: client?.call() ?? this.client,
      company: company?.call() ?? this.company,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
