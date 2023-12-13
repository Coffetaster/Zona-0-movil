import 'package:zona0_apk/domain/entities/entities.dart';

abstract class AccountsRemoteRepository {

  Future<dynamic> login({
    required String username,
    required String email,
    required String password,
    required Function(String token, Client? client, Company? company) loginCallback
  });
}