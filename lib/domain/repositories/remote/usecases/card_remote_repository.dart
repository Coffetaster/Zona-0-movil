import 'package:zona0_apk/domain/entities/entities.dart';

abstract class CardRemoteRepository {

  Future<Card> getCardDetails();

  Future<Card> activeCode(String idCard);
  Future<Card> desactiveCode(String idCard);

  Future<String> changeDiscountCode(String idCard);

  Future<Card> changeMinWithdraw(String idCard, double minWithdraw);

  Future<List<CardDiscount>> getDiscountSendList();

  Future<List<CardDiscount>> getDiscountReceiveList();

  Future<dynamic> createDiscountCard();
}