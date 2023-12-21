import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'account_provider.dart';

final accountFormResetPasswordConfirmProvider =
    StateNotifierProvider.autoDispose<AccountFormResetPasswordConfirmNotifier,
        AccountFormResetPasswordConfirmStatus>((ref) {
  return AccountFormResetPasswordConfirmNotifier(
      ref.read(accountProvider.notifier));
});

class AccountFormResetPasswordConfirmNotifier
    extends StateNotifier<AccountFormResetPasswordConfirmStatus> {
  AccountFormResetPasswordConfirmNotifier(this.accountNotifier)
      : super(AccountFormResetPasswordConfirmStatus());
  final AccountNotifier accountNotifier;

  void uidChanged(String value) {
    final uid = GeneralInput.dirty(value);
    state = state.copyWith(uid: uid, isvalid: validateForm(uid: uid));
  }

  void tokenChanged(String value) {
    final token = GeneralInput.dirty(value);
    state = state.copyWith(token: token, isvalid: validateForm(token: token));
  }

  void newPasswordChanged(String value) {
    final newPassword = PasswordInput.dirty(value,
        personalValidation:
            CustomPersonalValidation.passwordPersonalValidation);
    value = value.trim();
    bool passwordRequired1 =
        CustomPersonalValidation.validatePasswordRequired_Length(value);
    bool passwordRequired2 =
        CustomPersonalValidation.validatePasswordRequired_Case(value);
    bool passwordRequired3 =
        CustomPersonalValidation.validatePasswordRequired_Number(value);
    bool passwordRequired4 =
        CustomPersonalValidation.validatePasswordRequired_EspecialChar(value);
    state = state.copyWith(
        newPassword: newPassword,
        passwordRequired1: passwordRequired1,
        passwordRequired2: passwordRequired2,
        passwordRequired3: passwordRequired3,
        passwordRequired4: passwordRequired4,
        isvalid: validateForm(newPassword: newPassword));
  }

  void toggleObscureNewPassword() {
    state = state.copyWith(isObscureNewPassword: !state.isObscureNewPassword);
  }

  bool validateForm({
    GeneralInput? uid,
    GeneralInput? token,
    PasswordInput? newPassword,
  }) =>
      Formz.validate([
        uid ?? state.uid,
        token ?? state.token,
        newPassword ?? state.newPassword,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          uid: GeneralInput.dirty(state.uid.value),
          token: GeneralInput.dirty(state.token.value),
          newPassword: PasswordInput.dirty(state.newPassword.value,
              personalValidation:
                  CustomPersonalValidation.passwordPersonalValidation),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await accountNotifier.resetPasswordConfirm(
        uid: state.uid.realValue,
        token: state.token.realValue,
        new_password: state.newPassword.realValue,
      );
      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return Utils.getErrorsFromRegister(e.data);
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }

  void invalidFormStatus() =>
      state = state.copyWith(formStatus: FormStatus.invalid);

  AccountFormResetPasswordConfirmStatus get currentState => state;
}

class AccountFormResetPasswordConfirmStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput uid;
  final GeneralInput token;
  final PasswordInput newPassword;
  //* req1: longitud 8 o más
  final bool passwordRequired1;
  //* req2: contener mayúscula y minúscula
  final bool passwordRequired2;
  //* req3: contener números
  final bool passwordRequired3;
  //* req4: contener caracteres especiales
  final bool passwordRequired4;

  final bool isObscureNewPassword;

  double get percentSecurePassword {
    int cant = 0;
    if (passwordRequired1) cant++;
    if (passwordRequired2) cant++;
    if (passwordRequired3) cant++;
    if (passwordRequired4) cant++;
    return cant / 4;
  }

  AccountFormResetPasswordConfirmStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.uid = const GeneralInput.pure(),
    this.token = const GeneralInput.pure(),
    this.newPassword = const PasswordInput.pure(
        personalValidation:
            CustomPersonalValidation.passwordPersonalValidation),
    this.passwordRequired1 = false,
    this.passwordRequired2 = false,
    this.passwordRequired3 = false,
    this.passwordRequired4 = false,
    this.isObscureNewPassword = true,
  });

  AccountFormResetPasswordConfirmStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? uid,
    GeneralInput? token,
    PasswordInput? newPassword,
    bool? passwordRequired1,
    bool? passwordRequired2,
    bool? passwordRequired3,
    bool? passwordRequired4,
    bool? isObscureNewPassword,
  }) {
    return AccountFormResetPasswordConfirmStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      uid: uid ?? this.uid,
      token: token ?? this.token,
      newPassword: newPassword ?? this.newPassword,
      passwordRequired1: passwordRequired1 ?? this.passwordRequired1,
      passwordRequired2: passwordRequired2 ?? this.passwordRequired2,
      passwordRequired3: passwordRequired3 ?? this.passwordRequired3,
      passwordRequired4: passwordRequired4 ?? this.passwordRequired4,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
    );
  }
}
