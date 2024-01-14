import 'package:zona0_apk/data/models/transaction_model.dart';
import 'package:zona0_apk/domain/entities/transaction.dart';

extension TransactionMapper on Transaction {
  TransactionModel toModel() => TransactionModel(
      id: id,
      user: user,
      amount: amount,
      code: code,
      state: state,
      image: image,
      date: date,
      time: time);
}

extension TransactionModelMapper on TransactionModel {
  Transaction toEntity() => Transaction(
      id: id,
      user: user,
      amount: amount,
      code: code,
      state: state,
      image: image,
      date: date,
      time: time);
}
