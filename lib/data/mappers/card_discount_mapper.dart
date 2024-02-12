import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension CardDiscountMapper on CardDiscount {
  CardDiscountModel toModel() => CardDiscountModel(
      id: id, card: card, user: user, amount: amount, date: date, time: time);
}

extension CardDiscountModelMapper on CardDiscountModel {
  CardDiscount toEntity() => CardDiscount(
      id: id, card: card, user: user, amount: amount, date: date, time: time);
}
