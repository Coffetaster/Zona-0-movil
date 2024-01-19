import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/register_remote_repository.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.watch(connectivityStatusProvider.notifier);

  return RegisterNotifier(
      registerRemoteRepository: apiConsumer.register,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterRemoteRepository registerRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  RegisterNotifier(
      {required this.registerRemoteRepository,
      required this.connectivityStatusNotifier})
      : super(RegisterState());

  RegisterState get currentState => state;

  Future<int> registerClient(Client client, String imagePath) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await registerRemoteRepository.registerClient(client, imagePath);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<int> registerCompany(Company company, String imagePath) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await registerRemoteRepository.registerCompany(company, imagePath);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }
}

class RegisterState {

  RegisterState();
}
