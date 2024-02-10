import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension DepositMapper on Deposit {
  DepositModel toModel() => DepositModel(
      id: id,
      user: user,
      state: state,
      amount: amount,
      date: date,
      time: time,
      interest: interest,
      date_banked: date_banked,
      post_interest: post_interest);
}

extension DepositModelMapper on DepositModel {
  Deposit toEntity() => Deposit(
      id: id,
      user: user,
      state: state,
      amount: amount,
      date: date,
      time: time,
      interest: interest,
      date_banked: date_banked,
      post_interest: post_interest);
}
