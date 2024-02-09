import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class BankingApi extends BankingRemoteRepository {
  final MyDio _myDio;
  BankingApi(this._myDio);

  final String localUrl = "banking";

  @override
  Future createAccount(double amount) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/',
          requestType: RequestType.POST,
          data: {"amount": amount});
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Banking> getAccount(String idAccount) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/$idAccount/', requestType: RequestType.GET);
      print(json);
      return BankingModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<Banking>> getAccountList() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return List<Banking>.from(json.map((x) {
        return BankingModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future withdrawAccount(String idAccount) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/withdraw/$idAccount', requestType: RequestType.POST);
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
