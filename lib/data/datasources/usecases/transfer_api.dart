import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class TransferApi extends TransferRemoteRepository {
  final MyDio _myDio;
  TransferApi(this._myDio);

  final String localUrl = "transfer";

  List<TransactionReceived> _jsonToListTransactionReceived(List<dynamic> json) {
    return List<TransactionReceived>.from(json.map((x) {
      return TransactionReceivedModel.fromMap(x).toEntity();
    }));
  }

  List<TransactionSent> _jsonToListTransactionSent(List<dynamic> json) {
    return List<TransactionSent>.from(json.map((x) {
      return TransactionSentModel.fromMap(x).toEntity();
    }));
  }

  @override
  Future<TransactionReceived> createReceive(double amount) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/create-receive/',
          requestType: RequestType.POST,
          data: {"amount": amount});
      return TransactionReceivedModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<TransactionSent> createSend(String code) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/create-sendTransfer/',
          requestType: RequestType.POST,
          data: {"code": code});
      return TransactionSentModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<TransactionReceived> getReceive(String code) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/detail-receive/',
          requestType: RequestType.POST,
          data: {"code": code});
      return TransactionReceivedModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<void> deleteUnpaidReceive(int id) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-delete-unpaid-receive/$id',
          requestType: RequestType.DELETE);
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<TransactionSent>> getListSendTransfer() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-sendTransfer/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return _jsonToListTransactionSent(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<TransactionReceived>> getListPaidReceive() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-paid-receive/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return _jsonToListTransactionReceived(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<TransactionReceived>> getListUnpaidReceive() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-unpaid-receive/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return _jsonToListTransactionReceived(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
