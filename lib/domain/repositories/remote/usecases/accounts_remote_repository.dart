import 'package:zona0_apk/domain/entities/entities.dart';

abstract class AccountsRemoteRepository {

  Future<dynamic> login({
    required String usernameXemail,
    required String password,
    required Function(String? token, Client? client, Company? company) loginCallback
  });

  Future<dynamic> emailVerifyToken(String token);

  Future<dynamic> tokenRefresh({String? refresh});

  Future<dynamic> tokenVerify(String token);
}