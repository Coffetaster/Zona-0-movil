import 'package:zona0_apk/domain/entities/entities.dart';

abstract class InstitutionsRemoteRepository {

  Future<void> createDonation(Donation donation);

  Future<List<Donation>> getDonations();

  Future<Donation> getDonation(String id);

  Future<List<Institution>> getInstitutions();

  Future<Institution> getInstitution(String id);
}