import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class TransferApi extends TransferRemoteRepository {
  final MyDio _myDio;
  TransferApi(this._myDio);

  final String localUrl = "transfer";

  List<Transaction> _jsonToListTransaction(List<dynamic> json) {
    return List<Transaction>.from(json.map((x) {
      return TransactionModel.fromMap(x).toEntity();
    }));
  }

  @override
  Future<Transaction> createReceive(double amount) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/create-receive/',
          requestType: RequestType.POST,
          data: {"amount": amount});
      return TransactionModel.fromMap(json).toEntity();
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
  Future<List<Transaction>> getListPaidReceive() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-paid-receive/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return _jsonToListTransaction(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<Transaction>> getListUnpaidReceive() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-unpaid-receive/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return _jsonToListTransaction(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
/*
{
  id: 18,
  user: octagi,
  code: 25f23c61-625e-47d9-be66-5d36f6eeb317,
  state: Unpaid,
  amount: 500.0,
  image: https://drive.google.com/uc?id=1jWINfuKkcFWhrW-C2AdppPvCFnZaLHEb,
  date: 2024-01-14,
  time: 16:11:48.598608
}
*/
