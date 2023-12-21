import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';
import 'package:zona0_apk/domain/shared_preferences/my_shared.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final myShared = ref.read(mySharedProvider);
  final connectivityStatusNotifier =
      ref.watch(connectivityStatusProvider.notifier);

  return AccountNotifier(
      accountsRemoteRepository: apiConsumer.accounts,
      myShared: myShared,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class AccountNotifier extends StateNotifier<AccountState> {
  final MyShared myShared;
  final AccountsRemoteRepository accountsRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  AccountNotifier(
      {required this.accountsRemoteRepository,
      required this.myShared,
      required this.connectivityStatusNotifier})
      : super(AccountState()) {
    connectivityStatusNotifier.addListener((connectivityStatusState) {
      if (connectivityStatusState.isConnected) {
        _verifyToken();
      }
    });
  }

  Future<void> _verifyToken() async {
    if (state.isLogin) return;
    final token =
        await myShared.getValueNoNull<String>(MySharedConstants.token, "");
    if (token.isNotEmpty) {
      try {
        await accountsRemoteRepository.tokenVerify(token);
        String userJson =
            await myShared.getValueNoNull(MySharedConstants.user_data);
        state = state.copyWith(
          token: token,
          user: () => userJson.isNotEmpty ? User.fromJson(userJson) : null,
        );
        return;
      } on CustomDioError catch (e) {
        if (e.code == 401) {
          logout();
        }
      } catch (e) {}
    }
  }

  AccountState get currentState => state;

  Future<int> login({
    required String usernameXemail,
    required String password,
  }) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.login(
          usernameXemail: usernameXemail,
          password: password,
          loginCallback: (String? token, User? user) {
            myShared.setKeyValue<String>(MySharedConstants.token, token ?? '');
            myShared.setKeyValue<String>(
                MySharedConstants.user_data, user?.toJson());

            state = state.copyWith(token: token, user: () => user);
          });
      return 200;
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

  Future<int> verifyCode(String code) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.emailVerifyToken(code);
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<int> changePassword(String oldPassword, String newPassword) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.changePassword(oldPassword, newPassword);
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<int> resetPassword(String email) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.resetPassword(email);
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<int> resetPasswordConfirm(
      {required String uid,
      required String token,
      required String new_password}) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.resetPasswordConfirm(uid: uid, token: token, new_password: new_password);
      return 200;
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
