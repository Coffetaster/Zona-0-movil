import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension CardMapper on Card {
  CardModel toModel() => CardModel(
      id: id,
      user: user,
      min_withdraw: min_withdraw,
      active: active,
      discount_code: discount_code);
}

extension CardModelMapper on CardModel {
  Card toEntity() => Card(
      id: id,
      user: user,
      min_withdraw: min_withdraw,
      active: active,
      discount_code: discount_code);
}
