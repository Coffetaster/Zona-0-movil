import 'package:zona0_apk/domain/entities/entities.dart';

abstract class TransferRemoteRepository {

  Future<void> createReceive(double amount);

  Future<void> deleteUnpaidReceive(int id);

  Future<List<Transaction>> getListPaidReceive();

  Future<List<Transaction>> getListUnpaidReceive();
}