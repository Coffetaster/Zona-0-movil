import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/client.dart';
import 'package:zona0_apk/domain/entities/company.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/register_remote_repository.dart';

class RegisterApi extends RegisterRemoteRepository {
  final MyDio _myDio;
  RegisterApi(this._myDio);

  final String localUrl = "register/";

  @override
  Future<Client?> registerClient(Client client) async {
    try {
      ClientModel clientModel = ClientMapper.entity_to_model(client);
      final json = await _myDio.request(
          path: '$localUrl/client/',
          requestType: RequestType.POST,
          data: clientModel.toMap()..removeWhere((key, value) => key == 'id'));
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return ClientMapper.model_to_entity(ClientModel.fromMap(json));
    } on CustomDioError catch (err) {
      throw err;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Company?> registerCompany(Company company) async {
    try {
      CompanyModel companyModel = CompanyMapper.entity_to_model(company);
      final json = await _myDio.request(
          path: '$localUrl/company/',
          requestType: RequestType.POST,
          data: companyModel.toMap()..removeWhere((key, value) => key == 'id'));
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return CompanyMapper.model_to_entity(CompanyModel.fromMap(json));
    } on CustomDioError catch (err) {
      throw err;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

}