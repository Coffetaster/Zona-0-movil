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
  Future createDeposit(double amount) async {
    try {
      await _myDio.request(
          path: '$localUrl/account/',
          requestType: RequestType.POST,
          data: {"amount": amount});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Deposit> getDeposit(String idDeposit) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/$idDeposit/', requestType: RequestType.GET);
      return DepositModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<Deposit>> getDeposits() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return List<Deposit>.from(json.map((x) {
        return DepositModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future withdrawDeposit(String idDeposit) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/account/withdraw/?id=$idDeposit',
          requestType: RequestType.POST);
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
