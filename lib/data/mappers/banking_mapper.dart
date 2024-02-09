import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension BankingMapper on Banking {
  BankingModel toModel() => BankingModel(
      id: id, user: user, state: state, amount: amount, date: date, time: time);
}

extension BankingModelMapper on BankingModel {
  Banking toEntity() => Banking(
      id: id, user: user, state: state, amount: amount, date: date, time: time);
}
