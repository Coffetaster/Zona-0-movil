import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/client.dart';
import 'package:zona0_apk/domain/entities/company.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class UsersApi extends UsersRemoteRepository {
  final MyDio _myDio;
  UsersApi(this._myDio);

  final String localUrl = "users";

  @override
  Future<Client?> getMyDataClient() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/client-update/', requestType: RequestType.GET);
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return ClientModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Company?> getMyDataCompany() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/company-update/', requestType: RequestType.GET);
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return CompanyModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future updateDataClient(Client client) async {
    try {
      await _myDio.request(
          path: '$localUrl/client-update/${client.id}/',
          requestType: RequestType.PUT,
          requiredResponse: false,
          data: client.toModel().toMap()
            ..removeWhere((key, value) => (key == 'id' ||
                key == 'password' ||
                key == 'email')));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future updateDataCompany(Company company) async {
    try {
      await _myDio.request(
          path: '$localUrl/company-update/${company.id}/',
          requestType: RequestType.PUT,
          requiredResponse: false,
          data: company.toModel().toMap()
            ..removeWhere((key, value) => (key == 'id' ||
                key == 'password' ||
                key == 'email')));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
