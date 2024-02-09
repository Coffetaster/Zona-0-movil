import 'package:zona0_apk/domain/entities/entities.dart';

abstract class BankingRemoteRepository {

  Future<List<Banking>> getAccountList();

  Future<dynamic> createAccount(double amount);

  Future<dynamic> withdrawAccount(String idAccount);

  Future<Banking> getAccount(String idAccount);
}