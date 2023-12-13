import 'usecases/usecases.dart';

abstract class RemoteRepository {

  AccountsRemoteRepository get accounts;

  RegisterRemoteRepository get register;
}