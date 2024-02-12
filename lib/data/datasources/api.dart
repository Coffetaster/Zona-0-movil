import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/repositories/remote/remote_repository.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';

import 'usecases/usecases.dart';

class ApiConsumer extends RemoteRepository {
  late MyDio _myDio;

  //* usecases
  late AccountsApi _accountsApi;
  late RegisterApi _registerApi;
  late TransferApi _transferApi;
  late UsersApi _usersApi;
  late InstitutionsApi _institutionsApi;
  late RedeemCodeApi _redeemCodeApi;
  late BankingApi _bankingApi;
  late CardApi _cardApi;

  ApiConsumer() {
    _myDio = MyDio();

    //* usecases
    _accountsApi = AccountsApi(_myDio);
    _registerApi = RegisterApi(_myDio);
    _transferApi = TransferApi(_myDio);
    _usersApi = UsersApi(_myDio);
    _institutionsApi = InstitutionsApi(_myDio);
    _redeemCodeApi = RedeemCodeApi(_myDio);
    _bankingApi = BankingApi(_myDio);
    _cardApi = CardApi(_myDio);
  }

  @override
  AccountsRemoteRepository get accounts => _accountsApi;

  @override
  RegisterRemoteRepository get register => _registerApi;

  @override
  TransferRemoteRepository get transfer => _transferApi;

  @override
  UsersRemoteRepository get users => _usersApi;

  @override
  InstitutionsRemoteRepository get institutions => _institutionsApi;

  @override
  BankingRemoteRepository get banking => _bankingApi;

  @override
  RedeemCodeRemoteRepository get redeemCode => _redeemCodeApi;

  @override
  CardRemoteRepository get card => _cardApi;
}
