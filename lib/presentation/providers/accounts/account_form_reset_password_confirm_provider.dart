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
    state = state.copyWith(
        newPassword: newPassword,
        passwordRequired1: passwordRequired1,
        passwordRequired2: passwordRequired2,
        passwordRequired3: passwordRequired3,
        confirmPassword: PasswordInput.dirty(state.confirmPassword.realValue,
            passwordConfirm: state.newPassword.realValue),
        isvalid: validateForm(newPassword: newPassword));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = PasswordInput.dirty(value,
        passwordConfirm: state.newPassword.realValue);
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isvalid: validateForm(confirmPassword: confirmPassword));
  }

  void toggleObscureNewPassword() {
    state = state.copyWith(isObscureNewPassword: !state.isObscureNewPassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
        isObscureConfirmPassword: !state.isObscureConfirmPassword);
  }

  bool validateForm({
    GeneralInput? uid,
    GeneralInput? token,
    PasswordInput? newPassword,
    PasswordInput? confirmPassword,
  }) =>
      Formz.validate([
        uid ?? state.uid,
        token ?? state.token,
        newPassword ?? state.newPassword,
        confirmPassword ?? state.confirmPassword,
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
          confirmPassword: PasswordInput.dirty(state.confirmPassword.value,
              passwordConfirm: state.newPassword.realValue),
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
  final PasswordInput confirmPassword;

  final bool isObscureNewPassword;
  final bool isObscureConfirmPassword;

  double get percentSecurePassword {
    int cant = newPassword.realValue.length;
    if (cant > 8) cant = 8;
    if (passwordRequired2) cant += 4;
    if (passwordRequired3) cant += 4;
    return cant / 16;
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
    this.confirmPassword = const PasswordInput.pure(),
    this.isObscureNewPassword = true,
    this.isObscureConfirmPassword = true,
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
    PasswordInput? confirmPassword,
    bool? isObscureNewPassword,
    bool? isObscureConfirmPassword,
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
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
    );
  }
}
