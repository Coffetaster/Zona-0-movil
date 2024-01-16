import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension TransactionReceivedMapper on TransactionReceived {
  TransactionReceivedModel toModel() => TransactionReceivedModel(
      id: id,
      user: user,
      amount: amount,
      code: code,
      state: state,
      image: image,
      date: date,
      time: time);
}

extension TransactionReceivedModelMapper on TransactionReceivedModel {
  TransactionReceived toEntity() => TransactionReceived(
      id: id,
      user: user,
      amount: amount,
      code: code,
      state: state,
      image: image,
      date: date,
      time: time);
}
