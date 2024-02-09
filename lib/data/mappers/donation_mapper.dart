import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension DonationMapper on Donation {
  DonationModel toModel() => DonationModel(
      id: id, user: user, amount: amount, institution: institution);
}

extension DonationModelMapper on DonationModel {
  Donation toEntity() =>
      Donation(id: id, user: user, amount: amount, institution: institution);
}
