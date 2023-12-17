import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';
import 'package:zona0_apk/domain/shared_preferences/my_shared.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final myShared = ref.read(mySharedProvider);

  return AccountNotifier(
      accountsRemoteRepository: apiConsumer.accounts, myShared: myShared);
});

class AccountNotifier extends StateNotifier<AccountState> {
  final MyShared myShared;
  final AccountsRemoteRepository accountsRemoteRepository;

  AccountNotifier(
      {required this.accountsRemoteRepository, required this.myShared})
      : super(AccountState()) {
        initAccountData();
      }

  Future<void> initAccountData() async {
    String token = await myShared.getValueNoNull<String>(MySharedConstants.token, "");
    if(token.isNotEmpty){
      try {
        await accountsRemoteRepository.tokenVerify(token);
      } on CustomDioError catch (_) {
        token = "";
      } catch (e) {
        token = "";
      }
    }
    state = state.copyWith(token: () => token);
  }

  AccountState get currentState => state;

  Future<void> login({
    required String usernameXemail,
    required String password,
  }) async {
    try {
      await accountsRemoteRepository.login(
          usernameXemail: usernameXemail,
          password: password,
          loginCallback: (String? token, Client? client, Company? company) {
            myShared.setKeyValue(MySharedConstants.token, token ?? '');
            state = state.copyWith(
              token: () => token,
              client: () => client,
              company: () => company
            );
          });
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<void> verifyCode(String code) async {
    try {
      await accountsRemoteRepository.emailVerifyToken(code);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}

enum AccountStatus { checking, authenticated, notAuthenticated }

class AccountState {
  final AccountStatus authStatus;
  final String? token;
  final Client? client;
  final Company? company;
  final String errorMessage;
  final int errorCode;

  AccountState({
    this.authStatus = AccountStatus.checking,
    this.token,
    this.client,
    this.company,
    this.errorMessage = '',
    this.errorCode = 400
  });

  AccountState copyWith({
    AccountStatus? authStatus,
    ValueGetter<String?>? token,
    ValueGetter<Client?>? client,
    ValueGetter<Company?>? company,
    String? errorMessage,
    int? errorCode,
  }) {
    return AccountState(
      authStatus: authStatus ?? this.authStatus,
      token: token?.call() ?? this.token,
      client: client?.call() ?? this.client,
      company: company?.call() ?? this.company,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
