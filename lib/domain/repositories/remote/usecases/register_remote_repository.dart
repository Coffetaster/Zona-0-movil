import 'package:zona0_apk/domain/entities/entities.dart';

abstract class RegisterRemoteRepository {

  Future<Client?> registerClient(Client client);

  Future<Company?> registerCompany(Company company);
}