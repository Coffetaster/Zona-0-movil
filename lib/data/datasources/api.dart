
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/repositories/remote/remote_repository.dart';

class ApiConsumer extends RemoteRepository {

  static final RemoteRepository _instace = ApiConsumer._();
  late MyDio _myDio;

  static RemoteRepository getInstance() => _instace;

  ApiConsumer._() {
    _myDio = MyDio();
  }

}