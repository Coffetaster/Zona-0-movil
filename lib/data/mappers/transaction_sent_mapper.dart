import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension TransactionSentMapper on TransactionSent {
  TransactionSentModel toModel() => TransactionSentModel(
      id: id,
      user: user,
      amount: amount,
      receiveUser: receiveUser,
      date: date,
      time: time);
}

extension TransactionSentModelMapper on TransactionSentModel {
  TransactionSent toEntity() => TransactionSent(
      id: id,
      user: user,
      amount: amount,
      receiveUser: receiveUser,
      date: date,
      time: time);
}
