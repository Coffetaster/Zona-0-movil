import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

class RedeemCodeApi extends RedeemCodeRemoteRepository {
  final MyDio _myDio;
  RedeemCodeApi(this._myDio);

  final String localUrl = "redeem-code";

  @override
  Future redeem(String code) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/code/redeem/',
          requestType: RequestType.POST,
          data: {"code": code});
      print(json);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
