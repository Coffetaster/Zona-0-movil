import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/transaction.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final receiveOSPFormProvider = StateNotifierProvider.autoDispose<
    ReceiveOSPFormNotifier, ReceiveOSPFormState>((ref) {
  return ReceiveOSPFormNotifier(ref.read(transferProvider.notifier));
});

class ReceiveOSPFormNotifier
    extends StateNotifier<ReceiveOSPFormState> {
  ReceiveOSPFormNotifier(this._transferNotifier)
      : super(ReceiveOSPFormState());

  final TransferNotifier _transferNotifier;

  void amountChanged(String value) {
    final amount = DecimalInput.dirty(value);
    state = state.copyWith(amount: amount, isvalid: validateForm(amount: amount));
  }

  bool validateForm({
    DecimalInput? amount,
  }) =>
      Formz.validate([
        amount ?? state.amount,
      ]);

  Future<String> onSubmit(Function(Transaction transaction) callback) async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          amount: DecimalInput.dirty(state.amount.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await _transferNotifier.createReceive(state.amount.realValue, callback: callback);

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      // if (e.data == null) return "";
      // Map<String, dynamic> json = (e.data is String) ? jsonDecode(e.data) : e.data;
      // return json["detail"] ?? "";
      // return Utils.getErrorsFromXnon_field_errors(e.data);
      return e.data == null ? "" : "Código incorrecto";
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }
}

class ReceiveOSPFormState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final DecimalInput amount;

  ReceiveOSPFormState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.amount = const DecimalInput.pure(),
  });

  ReceiveOSPFormState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    DecimalInput? amount,
  }) {
    return ReceiveOSPFormState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      amount: amount ?? this.amount,
    );
  }
}
