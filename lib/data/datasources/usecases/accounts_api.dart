import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/company_mapper.dart';
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
      required Function(String? token, Client? client, Company? company)
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
      String? token = json["access"];
      Map<String, dynamic>? user = json["user"];
      if (token != null) _myDio.updateToken(token);
      if(user == null) loginCallback(token, null, null);
      else if (user['company_name'] != null) {
        loginCallback(token, null, CompanyMapper.model_to_entity(CompanyModel.fromMap(user)));
      } else {
        loginCallback(token, ClientMapper.model_to_entity(ClientModel.fromMap(user)), null);
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
      final json = await _myDio.request(
          path: '$localUrl/token/refresh/',
          requestType: RequestType.POST,
          data: {'refresh': refresh});
      print(json.toString());
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
      final json = await _myDio.request(
          path: '$localUrl/token/verify/',
          requestType: RequestType.POST,
          data: {'token': token});
      print(json.toString());
      _myDio.updateToken(token);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
