import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

typedef DonationsChangeListener = void Function(List<Donation> donationsList);

final institutionsProvider =
    StateNotifierProvider.autoDispose<InstitutionsNotifier, InstitutionsState>(
        (ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return InstitutionsNotifier(
      institutionsRemoteRepository: apiConsumer.institutions,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class InstitutionsNotifier extends StateNotifier<InstitutionsState> {
  final InstitutionsRemoteRepository institutionsRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;

  InstitutionsNotifier({
    required this.institutionsRemoteRepository,
    required this.connectivityStatusNotifier,
  }) : super(InstitutionsState()) {
    refresh();
  }

  InstitutionsState get currentState => state;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await getInstitutions();
    await getDonations();
    state = state.copyWith(isLoading: false);
  }

  Future<int> createDonation(Donation donation) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await institutionsRemoteRepository.createDonation(donation);
      getDonations();
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> getDonations() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<Donation> donationsList =
          await institutionsRemoteRepository.getDonations();
      state = state.copyWith(donationsList: donationsList);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(donationsList: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<Donation> getDonation(String id) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        throw CustomDioError(code: 498);
      }
      Donation donation = await institutionsRemoteRepository.getDonation(id);
      return donation;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> getInstitutions() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<Institution> institutionsList =
          await institutionsRemoteRepository.getInstitutions();
      state = state.copyWith(institutionsList: institutionsList);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(institutionsList: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<Institution> getInstitution(String id) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        throw CustomDioError(code: 498);
      }
      Institution institution =
          await institutionsRemoteRepository.getInstitution(id);
      return institution;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }
}

class InstitutionsState {
  final bool isLoading;
  final List<Donation> donationsList;
  final List<Institution> institutionsList;
  InstitutionsState({
    this.isLoading = false,
    this.donationsList = const [],
    this.institutionsList = const [],
  });

  InstitutionsState copyWith({
    bool? isLoading,
    List<Donation>? donationsList,
    List<Institution>? institutionsList,
  }) {
    return InstitutionsState(
      isLoading: isLoading ?? this.isLoading,
      donationsList: donationsList ?? this.donationsList,
      institutionsList: institutionsList ?? this.institutionsList,
    );
  }
}
