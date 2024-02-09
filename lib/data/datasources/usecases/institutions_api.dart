import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class InstitutionsApi extends InstitutionsRemoteRepository {
  final MyDio _myDio;
  InstitutionsApi(this._myDio);

  final String localUrl = "institutions";

  @override
  Future<void> createDonation(Donation donation) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/donations/',
          requestType: RequestType.POST,
          data: donation.toModel().toMap()
            ..removeWhere((key, value) => (key == 'id')));
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Donation> getDonation(String id) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/donations/${id}/', requestType: RequestType.GET);
      return DonationModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<Donation>> getDonations() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/donations/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return List<Donation>.from(json.map((x) {
        return DonationModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Institution> getInstitution(String id) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-institution/${id}/',
          requestType: RequestType.GET);
      return InstitutionModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<Institution>> getInstitutions() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/list-institution/', requestType: RequestType.GET);
      if (json == null || json.isEmpty) return [];
      return List<Institution>.from(json.map((x) {
        return InstitutionModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
