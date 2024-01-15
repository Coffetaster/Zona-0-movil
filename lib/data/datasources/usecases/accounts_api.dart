import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';

class AccountsApi extends AccountsRemoteRepository {
  final MyDio _myDio;
  AccountsApi(this._myDio);

  final String localUrl = "accounts";

  @override
  Future<void> login(
      {required String usernameXemail,
      required String password,
      required Function(String? token, User? user) loginCallback}) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/login/',
          requestType: RequestType.POST,
          data: {
            if (!usernameXemail.contains("@")) 'username': usernameXemail,
            if (usernameXemail.contains("@")) 'email': usernameXemail,
            'password': password
          });
      String? token = json["access"];
      Map<String, dynamic>? user = json["user"];
      if (token != null) _myDio.updateToken(token);
      if (user == null) {
        loginCallback(token, null);
      } else {
        loginCallback(
            token, UserModel.fromMap(user).toEntity());
      }
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> tokenRefresh({String? refresh}) async {
    try {
      await _myDio.request(
          path: '$localUrl/token/refresh/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {'refresh': refresh});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> emailVerifyToken(String token) async {
    try {
      await _myDio.request(
          path: '$localUrl/email/verify/' + token,
          requestType: RequestType.GET,
          requiredResponse: false);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> tokenVerify(String token) async {
    try {
      await _myDio.request(
          path: '$localUrl/token/verify/',
          requestType: RequestType.POST,
          data: {'token': token});
      _myDio.updateToken(token);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future changePassword(String oldPassword, String newPassword) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/change/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {'new_password1': oldPassword, 'new_password2': newPassword});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future resetPassword(String email) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/reset/',
          requestType: RequestType.POST,
          data: {'email': email});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future resetPasswordConfirm(
      {required String uid,
      required String token,
      required String new_password}) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/reset/confirm/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {
            'new_password1': new_password,
            'new_password2': new_password,
            'uid': uid,
            'token': token,
          });
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
