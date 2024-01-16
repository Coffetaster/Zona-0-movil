import 'package:zona0_apk/domain/entities/entities.dart';

abstract class TransferRemoteRepository {

  Future<TransactionReceived> createReceive(double amount);

  Future<TransactionSent> createSend(String code);

  Future<TransactionReceived> getReceive(String code);

  Future<void> deleteUnpaidReceive(int id);

  Future<List<TransactionSent>> getListSendTransfer();

  Future<List<TransactionReceived>> getListPaidReceive();

  Future<List<TransactionReceived>> getListUnpaidReceive();
}