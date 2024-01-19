import 'usecases/usecases.dart';

abstract class RemoteRepository {

  AccountsRemoteRepository get accounts;

  RegisterRemoteRepository get register;

  TransferRemoteRepository get transfer;

  UsersRemoteRepository get users;
}