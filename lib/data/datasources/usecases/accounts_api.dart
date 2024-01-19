import 'package:dio/dio.dart';
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
      required Function(String? accessToken, String? refreshToken, User? user)
          loginCallback}) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/login/',
          requestType: RequestType.POST,
          data: {
            if (!usernameXemail.contains("@")) 'username': usernameXemail,
            if (usernameXemail.contains("@")) 'email': usernameXemail,
            'password': password
          });
          print(json);
      String? accessToken = json["access"];
      String? refreshToken = json["refresh"];
      Map<String, dynamic>? user = json["user"];
      if (accessToken != null) _myDio.updateToken(accessToken);
      loginCallback(accessToken, refreshToken,
          user == null ? null : UserModel.fromMap(user).toEntity());
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> tokenRefresh(String? refreshToken,
      Function(String? accessToken, String? refreshToken) callback) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/token/refresh/',
          requestType: RequestType.POST,
          data: {'refresh': refreshToken});
      String? accessToken = json["access"];
      String? refreshTokenNew = json["refresh"];
      if (accessToken != null) _myDio.updateToken(accessToken);
      callback(accessToken, refreshTokenNew);
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
  Future<dynamic> tokenVerify(String accessToken) async {
    try {
      await _myDio.request(
          path: '$localUrl/token/verify/',
          requestType: RequestType.POST,
          data: {'token': accessToken});
      _myDio.updateToken(accessToken);
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

  @override
  Future<double> getOSPPoints() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/osp_points/', requestType: RequestType.GET);
      return json['orcaStore_point']?.toDouble() ?? 0.0;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<String> updateImageUser(String imagePath) async {
    try {
      final image = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath,
      );
      final json = await _myDio.requestMultipart(
          path: '$localUrl/update/image-user/',
          requestType: RequestType.PUT,
          data: FormData.fromMap({
            "image": [image]
          }));
      if (json == null || (json as Map<String, dynamic>).isEmpty) return "";
      return json["image"] ?? "";
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
