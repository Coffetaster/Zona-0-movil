import 'package:zona0_apk/domain/entities/entities.dart';

abstract class UsersRemoteRepository {

  Future<Client?> getMyDataClient();

  Future<dynamic> updateDataClient(Client client);

  Future<Company?> getMyDataCompany();

  Future<dynamic> updateDataCompany(Company company);
}
