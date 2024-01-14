import 'package:dio/dio.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/client.dart';
import 'package:zona0_apk/domain/entities/company.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/register_remote_repository.dart';

class RegisterApi extends RegisterRemoteRepository {
  final MyDio _myDio;
  RegisterApi(this._myDio);

  final String localUrl = "register";

  @override
  Future<Client?> registerClient(Client client, String imagePath) async {
    try {
      final image = await MultipartFile.fromFile(imagePath,
          filename: imagePath
          );
      final json = await _myDio.requestMultipart(
          path: '$localUrl/client/',
          requestType: RequestType.POST,
          data: FormData.fromMap(client.toModel().toMap()
            ..removeWhere((key, value) => key == 'id')
            ..addAll({"image": [image]})));
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return ClientModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Company?> registerCompany(Company company, String imagePath) async {
    try {
      final image = await MultipartFile.fromFile(imagePath,
          filename: imagePath,
          );
      final json = await _myDio.requestMultipart(
          path: '$localUrl/company/',
          requestType: RequestType.POST,
          data: FormData.fromMap(company.toModel().toMap()
            ..removeWhere((key, value) => key == 'id')
            ..addAll({"image": [image]})));
      if (json == null || (json as Map<String, dynamic>).isEmpty) return null;
      return CompanyModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
