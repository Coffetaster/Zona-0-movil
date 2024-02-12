import 'usecases/usecases.dart';

abstract class RemoteRepository {
  AccountsRemoteRepository get accounts;

  RegisterRemoteRepository get register;

  TransferRemoteRepository get transfer;

  UsersRemoteRepository get users;

  InstitutionsRemoteRepository get institutions;

  RedeemCodeRemoteRepository get redeemCode;

  BankingRemoteRepository get banking;

  CardRemoteRepository get card;
}
