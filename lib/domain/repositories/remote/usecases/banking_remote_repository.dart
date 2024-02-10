import 'package:zona0_apk/domain/entities/entities.dart';

abstract class BankingRemoteRepository {

  Future<List<Deposit>> getDeposits();

  Future<dynamic> createDeposit(double amount);

  Future<dynamic> withdrawDeposit(String idDeposit);

  Future<Deposit> getDeposit(String idDeposit);
}