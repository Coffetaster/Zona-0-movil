import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';

import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'redeem_code_provider.dart';

final redeemCodeFormProvider = StateNotifierProvider.autoDispose<
    RedeemCodeFormNotifier, RedeemCodeFormState>((ref) {
  return RedeemCodeFormNotifier(ref.read(redeemCodeProvider.notifier));
});

class RedeemCodeFormNotifier
    extends StateNotifier<RedeemCodeFormState> {
  RedeemCodeFormNotifier(this._redeemCodeNotifier)
      : super(RedeemCodeFormState());

  final RedeemCodeNotifier _redeemCodeNotifier;

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

      final code = await _redeemCodeNotifier.redeem(state.code.realValue);

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return Utils.getErrorsFromDioException(e.data, "Código incorrecto");
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }
}

class RedeemCodeFormState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput code;

  RedeemCodeFormState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.code = const GeneralInput.pure(),
  });

  RedeemCodeFormState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? code,
  }) {
    return RedeemCodeFormState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      code: code ?? this.code,
    );
  }
}
