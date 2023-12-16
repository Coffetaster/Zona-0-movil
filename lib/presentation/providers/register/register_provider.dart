import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/register_remote_repository.dart';
import 'package:zona0_apk/domain/shared_preferences/my_shared.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/data_providers/my_shared_provider.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final myShared = ref.read(mySharedProvider);

  return RegisterNotifier(
      registerRemoteRepository: apiConsumer.register, myShared: myShared);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final MyShared myShared;
  final RegisterRemoteRepository registerRemoteRepository;

  RegisterNotifier(
      {required this.registerRemoteRepository, required this.myShared})
      : super(RegisterState()) {}

  RegisterState get currentState => state;

  Future<int> registerClient(Client client, String imagePath) async {
    try {
      Client? response = await registerRemoteRepository.registerClient(client, imagePath);
      state = state.copyWith(
        client: () => response
      );
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  Future<int> registerCompany(Company company, String imagePath) async {
    try {
      Company? response = await registerRemoteRepository.registerCompany(company, imagePath);
      state = state.copyWith(
        company: () => response
      );
      return 200;
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      return 400;
    }
  }
}

class RegisterState {
  final Client? client;
  final Company? company;
  final String errorMessage;
  final int errorCode;

  RegisterState({
      this.client,
      this.company,
      this.errorMessage = '',
      this.errorCode = 400});


  RegisterState copyWith({
    ValueGetter<Client?>? client,
    ValueGetter<Company?>? company,
    String? errorMessage,
    int? errorCode,
  }) {
    return RegisterState(
      client: client?.call() ?? this.client,
      company: company?.call() ?? this.company,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
