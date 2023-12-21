import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';

import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/accounts/account_provider.dart';

final accountFormVerifyCodeProvider = StateNotifierProvider.autoDispose<
    AccountFormVerifyCodeNotifier, AccountFormVerifyCodeState>((ref) {
  return AccountFormVerifyCodeNotifier(ref.read(accountProvider.notifier));
});

class AccountFormVerifyCodeNotifier
    extends StateNotifier<AccountFormVerifyCodeState> {
  AccountFormVerifyCodeNotifier(this._accountNotifier)
      : super(AccountFormVerifyCodeState());

  final AccountNotifier _accountNotifier;

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

      final code = await _accountNotifier.verifyCode(state.code.realValue);

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

class AccountFormVerifyCodeState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput code;

  AccountFormVerifyCodeState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.code = const GeneralInput.pure(),
  });

  AccountFormVerifyCodeState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? code,
  }) {
    return AccountFormVerifyCodeState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      code: code ?? this.code,
    );
  }
}
