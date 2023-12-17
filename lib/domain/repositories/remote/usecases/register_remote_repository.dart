import 'package:zona0_apk/domain/entities/entities.dart';

abstract class RegisterRemoteRepository {

  Future<Client?> registerClient(Client client, String imagePath);

  Future<Company?> registerCompany(Company company, String imagePath);
}