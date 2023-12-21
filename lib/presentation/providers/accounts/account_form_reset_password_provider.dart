import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/presentation/providers/accounts/account_provider.dart';

final accountFormResetPasswordProvider = StateNotifierProvider.autoDispose<
    AccountFormResetPasswordNotifier, AccountFormResetPasswordState>((ref) {
  return AccountFormResetPasswordNotifier(ref.read(accountProvider.notifier));
});

class AccountFormResetPasswordNotifier
    extends StateNotifier<AccountFormResetPasswordState> {
  AccountFormResetPasswordNotifier(this._accountNotifier)
      : super(AccountFormResetPasswordState());

  final AccountNotifier _accountNotifier;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    state = state.copyWith(email: email, isvalid: validateForm(email: email));
  }

  bool validateForm({
    EmailInput? email,
  }) =>
      Formz.validate([
        email ?? state.email,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          email: EmailInput.dirty(state.email.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await _accountNotifier.resetPassword(state.email.realValue);

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (_) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }
}

class AccountFormResetPasswordState {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final EmailInput email;

  AccountFormResetPasswordState({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.email = const EmailInput.pure(),
  });

  AccountFormResetPasswordState copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    EmailInput? email,
  }) {
    return AccountFormResetPasswordState(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      email: email ?? this.email,
    );
  }
}
