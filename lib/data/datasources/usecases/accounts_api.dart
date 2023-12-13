import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';

class AccountsApi extends AccountsRemoteRepository {
  final MyDio _myDio;
  AccountsApi(this._myDio);

  final String localUrl = "accounts/";

  @override
  Future<void> login(
      {required String username,
      required String email,
      required String password,
      required Function(String token, Client? client, Company? company) loginCallback
    }) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/login/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {
            if(username.isNotEmpty) 'username': username,
            if(email.isNotEmpty) 'email': email,
            'password': password
          });
      print(json);
      loginCallback("",null,null);
    } on CustomDioError catch (err) {
      throw err;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
