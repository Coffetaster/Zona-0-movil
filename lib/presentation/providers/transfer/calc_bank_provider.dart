import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/domain/inputs/inputs.dart';

final calcBankProvider =
    StateNotifierProvider.autoDispose<CalcBankNotifier, CalcBankState>((ref) {
  return CalcBankNotifier();
});

class CalcBankNotifier extends StateNotifier<CalcBankState> {
  CalcBankNotifier() : super(CalcBankState());

  void updateAmountTotal() {
    if (!state.isvalid) return;
    final amountTotal =
        (state.amount.realValue * (state.days.realValue / 30) * (3 / 100)) +
            state.amount.realValue;
    state = state.copyWith(amountTotal: amountTotal);
  }

  int? incrementDay() {
    if (state.days.isValid) {
      final daysValue = state.days.realValue + 30;
      daysChanged(daysValue.toString());
      return daysValue;
    }
    return null;
  }

  int? decrementDay() {
    if (state.days.isValid && state.days.realValue > 30) {
      final daysValue =
          state.days.realValue - 30 < 30 ? 30 : state.days.realValue - 30;
      daysChanged(daysValue.toString());
      return daysValue;
    }
    return null;
  }

  void amountChanged(String value) {
    final amount = DecimalInput.dirty(value,
        personalValidation: CustomPersonalValidation.unsignedDecimalValidation);
    state =
        state.copyWith(amount: amount, isvalid: validateForm(amount: amount));
    updateAmountTotal();
  }

  void daysChanged(String value) {
    final days = NumberInput.dirty(value,
        personalValidation: CustomPersonalValidation.unsignedNumberValidation);
    state = state.copyWith(days: days, isvalid: validateForm(days: days));
    updateAmountTotal();
  }

  bool validateForm({
    DecimalInput? amount,
    NumberInput? days,
  }) =>
      Formz.validate([amount ?? state.amount, days ?? state.days]);
}

class CalcBankState {
  final bool isvalid;
  final double amountTotal;
  final NumberInput days;
  final DecimalInput amount;
  CalcBankState({
    this.isvalid = true,
    this.amountTotal = 0,
    this.days = const NumberInput.dirty("30",
        personalValidation: CustomPersonalValidation.unsignedDecimalValidation),
    this.amount = const DecimalInput.dirty("0",
        personalValidation: CustomPersonalValidation.unsignedDecimalValidation),
  });

  CalcBankState copyWith({
    bool? isvalid,
    double? amountTotal,
    NumberInput? days,
    DecimalInput? amount,
  }) {
    return CalcBankState(
      isvalid: isvalid ?? this.isvalid,
      amountTotal: amountTotal ?? this.amountTotal,
      days: days ?? this.days,
      amount: amount ?? this.amount,
    );
  }
}
