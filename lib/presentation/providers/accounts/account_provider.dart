import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/shared_preferences/my_shared.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final myShared = ref.read(mySharedProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return AccountNotifier(
      accountsRemoteRepository: apiConsumer.accounts,
      myShared: myShared,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class AccountNotifier extends StateNotifier<AccountState> {
  final MyShared myShared;
  final AccountsRemoteRepository accountsRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;
  Timer? _timerHandle;

  AccountNotifier(
      {required this.accountsRemoteRepository,
      required this.myShared,
      required this.connectivityStatusNotifier})
      : super(AccountState()) {
    connectivityStatusNotifier.addListener((connectivityStatusState) {
      if (connectivityStatusState.isConnected) {
        _verifyToken();
      } else {
        _cancelTimer();
      }
    });
  }

  Future<void> _verifyToken() async {
    if (state.isLogin) {
      _mustRefreshToken();
      return;
    }
    final accessToken = await myShared.getValueNoNull<String>(
        MySharedConstants.accessToken, "");
    if (accessToken.isNotEmpty) {
      state = state.copyWith(isVerifyToken: true);
      try {
        await accountsRemoteRepository.tokenVerify(accessToken);
        final refreshToken = await myShared.getValueNoNull<String>(
            MySharedConstants.refreshToken, "");
        String userJson =
            await myShared.getValueNoNull(MySharedConstants.user_data);
        state = state.copyWith(
            accessToken: accessToken,
            refreshToken: refreshToken,
            user: () => userJson.isNotEmpty ? User.fromJson(userJson) : null,
            isVerifyToken: false);
        _mustRefreshToken();
        return;
      } on CustomDioError catch (e) {
        if (e.code == 401) {
          logout();
        }
      } catch (e) {}
      state = state.copyWith(isVerifyToken: false);
    }
  }

  Future<void> _mustRefreshToken() async {
    _cancelTimer();
    if (connectivityStatusNotifier.isConnected && state.isLogin) {
      try {
        await accountsRemoteRepository.tokenRefresh(state.refreshToken,
            (accessToken, refreshToken) {
          myShared.setKeyValue<String>(
              MySharedConstants.accessToken, accessToken ?? '');
          myShared.setKeyValue<String>(
              MySharedConstants.refreshToken, refreshToken ?? '');

          state = state.copyWith(
              accessToken: accessToken, refreshToken: refreshToken);
        });
        getOSPPoints();
      } on CustomDioError catch (_) {
        connectivityStatusNotifier.checkedConnection();
      } catch (e) {
        connectivityStatusNotifier.checkedConnection();
      }
      _startTimer(_mustRefreshToken);
    }
  }

  void _cancelTimer() async {
    _timerHandle?.cancel();
  }

  void _startTimer(Function() callback) async {
    _cancelTimer();
    _timerHandle =
        Timer(const Duration(milliseconds: 1000 * 60 * 15), callback);
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
          loginCallback:
              (String? accessToken, String? refreshToken, User? user) {
            myShared.setKeyValue<String>(
                MySharedConstants.accessToken, accessToken ?? '');
            myShared.setKeyValue<String>(
                MySharedConstants.refreshToken, refreshToken ?? '');
            myShared.setKeyValue<String>(
                MySharedConstants.user_data, user?.toJson());

            state = state.copyWith(
                accessToken: accessToken,
                refreshToken: refreshToken,
                user: () => user);

            _startTimer(_mustRefreshToken);
          });
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> logout() async {
    _cancelTimer();
    myShared.setKeyValue<String>(MySharedConstants.accessToken, '');
    myShared.setKeyValue<String>(MySharedConstants.refreshToken, '');
    myShared.setKeyValue<String>(MySharedConstants.user_data, null);
    state = state.copyWith(accessToken: "", refreshToken: "", user: () => null);
  }

  Future<int> verifyCode(String code) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.emailVerifyToken(code);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
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
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
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
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
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
      await accountsRemoteRepository.resetPasswordConfirm(
          uid: uid, token: token, new_password: new_password);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> getOSPPoints() async {
    try {
      if (connectivityStatusNotifier.isConnected &&
          state.isLogin &&
          state.user != null) {
        double ospPoints = await accountsRemoteRepository.getOSPPoints();
        state = state.copyWith(
            user: () => state.user?.copyWith(ospPoint: ospPoints));
        updateSaveUser();
      }
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<int> imageChange(String imagePath) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      state = state.copyWith(changingProfileImage: true);
      final url = await accountsRemoteRepository.updateImageUser(imagePath);
      state = state.copyWith(user: () => state.user?.copyWith(image: url), changingProfileImage: false);
      updateSaveUser();
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> updateSaveUser() async {
    if (state.user == null) return;
    await myShared.setKeyValue<String>(
        MySharedConstants.user_data, state.user!.toJson());
  }

  void updateDataUserOfClient(Client client) {
    state = state.copyWith(user: () => state.user?.copyWith(
      name: client.name,
      lastName: client.last_name,
      ci: client.ci,
      movil: client.movil,
      username: client.username,
    ));
    updateSaveUser();
  }

  void updateDataUserOfCompany(Company company) {
    state = state.copyWith(user: () => state.user?.copyWith(
      name: company.name,
      lastName: company.last_name,
      ci: company.ci,
      movil: company.movil,
      username: company.username,
    ));
    updateSaveUser();
  }
}

enum AccountStatus { checking, authenticated, notAuthenticated }

class AccountState {
  final AccountStatus authStatus;
  final String accessToken;
  final String refreshToken;
  final User? user;
  final String errorMessage;
  final int errorCode;
  final bool isVerifyToken;
  final bool changingProfileImage;

  AccountState({
    this.authStatus = AccountStatus.checking,
      this.accessToken = '',
      this.refreshToken = '',
      this.user,
      this.errorMessage = '',
      this.errorCode = 400,
      this.isVerifyToken = false,
      this.changingProfileImage = false,
      });

  bool get isLogin => accessToken.isNotEmpty;
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
      return user!.lastName;
    }
    return '';
  }

  double get ospPoint {
    if (!isLogin) return 0;
    if (user != null) {
      return user!.ospPoint;
    }
    return 0;
  }

  bool get isClient {
    if (!isLogin) return false;
    if (user != null) {
      return user!.isClient;
    }
    return false;
  }

  bool get isCompany {
    if (!isLogin) return false;
    if (user != null) {
      return user!.isCompany;
    }
    return false;
  }

  AccountState copyWith({
    AccountStatus? authStatus,
    String? accessToken,
    String? refreshToken,
    ValueGetter<User?>? user,
    String? errorMessage,
    int? errorCode,
    bool? isVerifyToken,
    bool? changingProfileImage,
  }) {
    return AccountState(
      authStatus: authStatus ?? this.authStatus,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user != null ? user() : this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      isVerifyToken: isVerifyToken ?? this.isVerifyToken,
      changingProfileImage: changingProfileImage ?? this.changingProfileImage,
    );
  }
}
