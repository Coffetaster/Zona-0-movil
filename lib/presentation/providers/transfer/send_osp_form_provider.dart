import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/helpers/utils.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final sendOSPFormProvider =
    StateNotifierProvider.autoDispose<SendOSPFormNotifier, SendOSPFormState>(
        (ref) {
  return SendOSPFormNotifier(ref.read(transferProvider.notifier));
});

class SendOSPFormNotifier extends StateNotifier<SendOSPFormState> {
  SendOSPFormNotifier(this._transferNotifier) : super(SendOSPFormState());

  final TransferNotifier _transferNotifier;

  void codeChanged(String value) {
    final code = GeneralInput.dirty(value);
    state = state.copyWith(code: code, isvalid: validateForm(code: code));
  }

  bool validateForm({
    GeneralInput? code,
  }) =>
      Formz.validate([
        code ?? state.code,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          code: GeneralInput.dirty(state.code.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      int code = 200;
      if (state.transactionToPay == null) {
        final transaction =
            await _transferNotifier.getReceive(state.code.realValue);
        state = state.copyWith(transactionToPay: () => transaction);
        code = 100;
      } else {
        code = await _transferNotifier.createSend(state.code.realValue);
      }
      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return Utils.getErrorsFromDioException(e.data);
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }
}

class SendOSPFormState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput code;
  TransactionReceived? transactionToPay;

  SendOSPFormState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.code = const GeneralInput.pure(),
    this.transactionToPay = null
  });

  SendOSPFormState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? code,
    ValueGetter<TransactionReceived?>? transactionToPay,
  }) {
    return SendOSPFormState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      code: code ?? this.code,
      transactionToPay: transactionToPay != null ? transactionToPay() : this.transactionToPay,
    );
  }
}
