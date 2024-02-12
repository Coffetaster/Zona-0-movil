import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/repositories/remote/usecases/usecases.dart';
import 'package:zona0_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final cardProvider =
    StateNotifierProvider.autoDispose<CardNotifier, CardState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return CardNotifier(
      cardRemoteRepository: apiConsumer.card,
      connectivityStatusNotifier: connectivityStatusNotifier,
      getOSPPoints: ref.read(accountProvider.notifier).getOSPPoints);
});

class CardNotifier extends StateNotifier<CardState> {
  final CardRemoteRepository cardRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;
  final Function() getOSPPoints;

  CardNotifier({
    required this.cardRemoteRepository,
    required this.connectivityStatusNotifier,
    required this.getOSPPoints,
  }) : super(CardState()) {
    refresh();
  }

  CardState get currentState => state;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await getCardDetails();
    state = state.copyWith(isLoading: false);
  }

  Future<String> getCardDetails() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return "498";
      final card = await cardRemoteRepository.getCardDetails();
      state = state.copyWith(myCard: () => card);
      await getDiscountList();
      return "200";
    } on CustomDioError catch (e) {
      connectivityStatusNotifier.checkedConnection();
      return Utils.getErrorsFromDioException(e.data);
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
    return "";
  }

  Future<String> changeDiscountCode() async {
    if (state.myCard == null) return "";
    try {
      if (!connectivityStatusNotifier.isConnected) return "498";
      final discount_code = await cardRemoteRepository
          .changeDiscountCode(state.myCard!.id.toString());
      if (discount_code.isNotEmpty) {
        state = state.copyWith(
            myCard: () => state.myCard!.copyWith(discount_code: discount_code));
      }
      return "200";
    } on CustomDioError catch (e) {
      connectivityStatusNotifier.checkedConnection();
      return Utils.getErrorsFromDioException(e.data);
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
    return "";
  }

  Future<String> changeMinWithdraw(double minWithdraw) async {
    if (state.myCard == null) return "";
    try {
      if (!connectivityStatusNotifier.isConnected) return "498";
      final card = await cardRemoteRepository.changeMinWithdraw(
          state.myCard!.id.toString(), minWithdraw);
      state = state.copyWith(myCard: () => card);
      return "200";
    } on CustomDioError catch (e) {
      connectivityStatusNotifier.checkedConnection();
      return Utils.getErrorsFromDioException(e.data);
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
    return "";
  }

  Future<dynamic> getDiscountReceiveList() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<CardDiscount> discounts =
          await cardRemoteRepository.getDiscountReceiveList();
      state = state.copyWith(discountsReceive: discounts);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(discountsReceive: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<dynamic> getDiscountSendList() async {
    try {
      if (!connectivityStatusNotifier.isConnected) return;
      List<CardDiscount> discounts =
          await cardRemoteRepository.getDiscountSendList();
      state = state.copyWith(discountsSend: discounts);
    } on CustomDioError catch (e) {
      if (e.code == 404) {
        state = state.copyWith(discountsSend: []);
      } else {
        connectivityStatusNotifier.checkedConnection();
      }
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
  }

  Future<dynamic> createDiscountCard() async {}

  Future<String> toggleStateActiveCard() async {
    if (state.myCard == null) return "";
    try {
      if (!connectivityStatusNotifier.isConnected) return "498";
      late Card card;
      if (state.myCard!.active) {
        card = await cardRemoteRepository
            .desactiveCode(state.myCard!.id.toString());
      } else {
        card =
            await cardRemoteRepository.activeCode(state.myCard!.id.toString());
      }
      state = state.copyWith(myCard: () => card);
      return "200";
    } on CustomDioError catch (e) {
      connectivityStatusNotifier.checkedConnection();
      return Utils.getErrorsFromDioException(e.data);
    } catch (_) {
      connectivityStatusNotifier.checkedConnection();
    }
    return "";
  }

  Future<void> getDiscountList() async {
    await getDiscountReceiveList();
    await getDiscountSendList();
  }

}

class CardState {
  final bool isLoading;
  final Card? myCard;
  final List<CardDiscount> discountsSend;
  final List<CardDiscount> discountsReceive;
  CardState({
    this.isLoading = false,
    this.myCard,
    this.discountsSend = const [],
    this.discountsReceive = const [],
  });

  CardState copyWith({
    bool? isLoading,
    ValueGetter<Card?>? myCard,
    List<CardDiscount>? discountsSend,
    List<CardDiscount>? discountsReceive,
  }) {
    return CardState(
      isLoading: isLoading ?? this.isLoading,
      myCard: myCard != null ? myCard() : this.myCard,
      discountsSend: discountsSend ?? this.discountsSend,
      discountsReceive: discountsReceive ?? this.discountsReceive,
    );
  }
}
