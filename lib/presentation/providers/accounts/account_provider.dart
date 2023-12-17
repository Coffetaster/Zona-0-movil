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
    String token =
        await myShared.getValueNoNull<String>(MySharedConstants.token, "");
    if (token.isNotEmpty) {
      try {
        await accountsRemoteRepository.tokenVerify(token);
        String userJson = await myShared.getValueNoNull(MySharedConstants.user_data);
        state = state.copyWith(
          token: token,
          user: () => userJson.isNotEmpty ? User.fromJson(userJson) : null,
        );
        return;
      } on CustomDioError catch (_) {
        token = "";
      } catch (e) {
        token = "";
      }
    }
    state = state.copyWith(token: token);
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
          loginCallback: (String? token, User? user) {
            myShared.setKeyValue<String>(MySharedConstants.token, token ?? '');
            myShared.setKeyValue<String>(
                MySharedConstants.user_data, user?.toJson());

            state = state.copyWith(token: token, user: () => user);
          });
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<void> logout() async {
    myShared.setKeyValue<String>(MySharedConstants.token, '');
    myShared.setKeyValue<String>(MySharedConstants.user_data, null);

    state = state.copyWith(token: "", user: () => null);
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
  final String token;
  final User? user;
  final String errorMessage;
  final int errorCode;

  AccountState(
      {this.authStatus = AccountStatus.checking,
      this.token = '',
      this.user,
      this.errorMessage = '',
      this.errorCode = 400});

  bool get isLogin => token.isNotEmpty;
  String get id {
    if (!isLogin) return '';
    if (user != null) {
      return user!.id.toString();
    }
    return '';
  }

  String get username {
    if (!isLogin) return '';
    if (user != null) {
      return user!.username;
    }
    return '';
  }

  String get imagePath {
    if (!isLogin) return '';
    if (user != null) {
      return user!.image;
    }
    return '';
  }

  String get name {
    if (!isLogin) return '';
    if (user != null) {
      return user!.name;
    }
    return '';
  }

  String get last_name {
    if (!isLogin) return '';
    if (user != null) {
      return user!.last_name;
    }
    return '';
  }

  AccountState copyWith({
    AccountStatus? authStatus,
    String? token,
    ValueGetter<User?>? user,
    String? errorMessage,
    int? errorCode,
  }) {
    return AccountState(
      authStatus: authStatus ?? this.authStatus,
      token: token ?? this.token,
      user: user?.call() ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
