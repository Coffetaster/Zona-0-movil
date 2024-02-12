import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/data/mappers/mappers.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/card_discount.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class CardApi extends CardRemoteRepository {
  final MyDio _myDio;
  CardApi(this._myDio);

  final String localUrl = "card";

  @override
  Future<Card> activeCode(String idCard) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/card-details/active_code/?id=$idCard',
          requestType: RequestType.PUT);
      return CardModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<String> changeDiscountCode(String idCard) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/card-details/change_discount_code/?id=$idCard',
          requestType: RequestType.PUT);
      return json['discount_code'] ?? '';
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Card> changeMinWithdraw(String idCard, double minWithdraw) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/card-details/min_withdraw_code/?id=$idCard',
          requestType: RequestType.PUT,
          data: {"min_withdraw": minWithdraw});
      return CardModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future createDiscountCard() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/my-card-discount/', requestType: RequestType.POST);
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Card> desactiveCode(String idCard) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/card-details/desactive_code/?id=$idCard',
          requestType: RequestType.PUT);
      return CardModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<Card> getCardDetails() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/card-details/', requestType: RequestType.GET);
      return CardModel.fromMap(json).toEntity();
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<CardDiscount>> getDiscountReceiveList() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/your-card-discount/', requestType: RequestType.GET);
      print(json);
      if (json == null || json.isEmpty) return [];
      return List<CardDiscount>.from(json.map((x) {
        return CardDiscountModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<List<CardDiscount>> getDiscountSendList() async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/my-card-discount/', requestType: RequestType.GET);
      print(json);
      if (json == null || json.isEmpty) return [];
      return List<CardDiscount>.from(json.map((x) {
        return CardDiscountModel.fromMap(x).toEntity();
      }));
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
