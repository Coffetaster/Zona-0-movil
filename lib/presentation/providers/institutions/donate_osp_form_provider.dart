import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/donation.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';

final donateOSPFormProvider = StateNotifierProvider.autoDispose<
    DonateOSPFormNotifier, DonateOSPFormState>((ref) {
  return DonateOSPFormNotifier(
    ref.read(accountProvider).id,
    ref.read(institutionsProvider.notifier));
});

class DonateOSPFormNotifier extends StateNotifier<DonateOSPFormState> {
  DonateOSPFormNotifier(this._idUser, this._institutionsNotifier)
      : super(DonateOSPFormState());

  final String _idUser;
  final InstitutionsNotifier _institutionsNotifier;

  void amountChanged(String value) {
    final amount = DecimalInput.dirty(value);
    state =
        state.copyWith(amount: amount, isvalid: validateForm(amount: amount));
  }

  bool validateForm({
    DecimalInput? amount,
  }) =>
      Formz.validate([
        amount ?? state.amount,
      ]);

  Future<String> onSubmit(String institutionId) async {
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

      final code = await _institutionsNotifier.createDonation(Donation(
          id: 0,
          user: _idUser,
          amount: state.amount.realValue,
          institution: institutionId));

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

class DonateOSPFormState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final DecimalInput amount;

  DonateOSPFormState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.amount = const DecimalInput.pure(),
  });

  DonateOSPFormState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    DecimalInput? amount,
  }) {
    return DonateOSPFormState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      amount: amount ?? this.amount,
    );
  }
}
