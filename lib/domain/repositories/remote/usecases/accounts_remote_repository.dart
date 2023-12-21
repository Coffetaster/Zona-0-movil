import 'package:zona0_apk/domain/entities/entities.dart';

abstract class AccountsRemoteRepository {
  Future<dynamic> login(
      {required String usernameXemail,
      required String password,
      required Function(String? token, User? user) loginCallback});

  Future<dynamic> emailVerifyToken(String token);

  Future<dynamic> tokenRefresh({String? refresh});

  Future<dynamic> tokenVerify(String token);

  Future<dynamic> changePassword(String oldPassword, String newPassword);

  Future<dynamic> resetPassword(String email);

  Future<dynamic> resetPasswordConfirm(
      {required String uid,
      required String token,
      required String new_password});
}
