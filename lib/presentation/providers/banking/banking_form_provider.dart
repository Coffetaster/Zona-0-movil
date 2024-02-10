import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final bankingFormProvider =
    StateNotifierProvider.autoDispose<BankingFormNotifier, BankingFormState>(
        (ref) {
  return BankingFormNotifier(ref.read(bankingProvider.notifier));
});

class BankingFormNotifier extends StateNotifier<BankingFormState> {
  BankingFormNotifier(this._bankingNotifier) : super(BankingFormState());

  final BankingNotifier _bankingNotifier;
  final TextEditingController _controllerForm = TextEditingController(text: "");
  TextEditingController get controllerForm => _controllerForm;
  @override
  void dispose() {
    _controllerForm.dispose();
    super.dispose();
  }

  void amountChanged(String value) {
    final amount = DecimalInput.dirty(value,
        personalValidation: CustomPersonalValidation.unsignedDecimalValidation);
    state =
        state.copyWith(amount: amount, isvalid: validateForm(amount: amount));
  }

  bool validateForm({
    DecimalInput? amount,
  }) =>
      Formz.validate([
        amount ?? state.amount,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          amount: DecimalInput.dirty(state.amount.value,
              personalValidation:
                  CustomPersonalValidation.unsignedDecimalValidation),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await _bankingNotifier.createDeposit(state.amount.realValue);

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return e.data == null ? "" : "Monto incorrecto";
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }

  void reset() {
    state = BankingFormState();
    _controllerForm.value = _controllerForm.value.copyWith(text: "");
  }
}

class BankingFormState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final DecimalInput amount;

  BankingFormState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.amount = const DecimalInput.pure(
        personalValidation: CustomPersonalValidation.unsignedDecimalValidation),
  });

  BankingFormState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    DecimalInput? amount,
  }) {
    return BankingFormState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      amount: amount ?? this.amount,
    );
  }
}
