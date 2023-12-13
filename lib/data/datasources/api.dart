
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/repositories/remote/remote_repository.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

import 'usecases/usecases.dart';

class ApiConsumer extends RemoteRepository {
  late MyDio _myDio;

  //* usecases
  late AccountsApi _accountsApi;
  late RegisterApi _registerApi;

  ApiConsumer() {
    _myDio = MyDio();

    //* usecases
    _accountsApi = AccountsApi(_myDio);
    _registerApi = RegisterApi(_myDio);

  }

  @override
  AccountsRemoteRepository get accounts => _accountsApi;

  @override
  RegisterRemoteRepository get register => _registerApi;

}