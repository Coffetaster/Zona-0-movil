import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'account_provider.dart';

final changePasswordFormProvider = StateNotifierProvider.autoDispose<
    ChangePasswordFormNotifier, ChangePasswordFormStatus>((ref) {
  return ChangePasswordFormNotifier(ref.read(accountProvider.notifier));
});

class ChangePasswordFormNotifier
    extends StateNotifier<ChangePasswordFormStatus> {
  ChangePasswordFormNotifier(this.accountNotifier)
      : super(ChangePasswordFormStatus());
  final AccountNotifier accountNotifier;

  void oldPasswordChanged(String value) {
    final oldPassword = PasswordInput.dirty(value);
    state = state.copyWith(
        oldPassword: oldPassword,
        isvalid: validateForm(oldPassword: oldPassword));
  }

  void newPasswordChanged(String value) {
    //* borrar si es necesario
    oldPasswordChanged(value);
    //*
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

  void toggleObscureOldPassword() {
    state = state.copyWith(isObscureOldPassword: !state.isObscureOldPassword);
  }

  void toggleObscureNewPassword() {
    state = state.copyWith(isObscureNewPassword: !state.isObscureNewPassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
        isObscureConfirmPassword: !state.isObscureConfirmPassword);
  }

  bool validateForm({
    PasswordInput? oldPassword,
    PasswordInput? newPassword,
    PasswordInput? confirmPassword,
  }) =>
      Formz.validate([
        oldPassword ?? state.oldPassword,
        newPassword ?? state.newPassword,
        confirmPassword ?? state.confirmPassword,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          oldPassword: PasswordInput.dirty(state.oldPassword.value),
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

      final code = await accountNotifier.changePassword(
          state.oldPassword.realValue, state.newPassword.realValue);
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

  ChangePasswordFormStatus get currentState => state;
}

class ChangePasswordFormStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final PasswordInput oldPassword;
  final PasswordInput newPassword;
  //* req1: longitud 8 o más
  final bool passwordRequired1;
  //* req2: contener mayúscula y minúscula
  final bool passwordRequired2;
  //* req3: contener números
  final bool passwordRequired3;
  final PasswordInput confirmPassword;

  final bool isObscureOldPassword;
  final bool isObscureNewPassword;
  final bool isObscureConfirmPassword;

  double get percentSecurePassword {
    int cant = newPassword.realValue.length;
    if (cant > 8) cant = 8;
    if (passwordRequired2) cant += 4;
    if (passwordRequired3) cant += 4;
    return cant / 16;
  }

  ChangePasswordFormStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.oldPassword = const PasswordInput.pure(),
    this.newPassword = const PasswordInput.pure(
        personalValidation:
            CustomPersonalValidation.passwordPersonalValidation),
    this.passwordRequired1 = false,
    this.passwordRequired2 = false,
    this.passwordRequired3 = false,
    this.confirmPassword = const PasswordInput.pure(),
    this.isObscureOldPassword = true,
    this.isObscureNewPassword = true,
    this.isObscureConfirmPassword = true,
  });

  ChangePasswordFormStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    PasswordInput? oldPassword,
    PasswordInput? newPassword,
    bool? passwordRequired1,
    bool? passwordRequired2,
    bool? passwordRequired3,
    PasswordInput? confirmPassword,
    bool? isObscureOldPassword,
    bool? isObscureNewPassword,
    bool? isObscureConfirmPassword,
  }) {
    return ChangePasswordFormStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      passwordRequired1: passwordRequired1 ?? this.passwordRequired1,
      passwordRequired2: passwordRequired2 ?? this.passwordRequired2,
      passwordRequired3: passwordRequired3 ?? this.passwordRequired3,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscureOldPassword: isObscureOldPassword ?? this.isObscureOldPassword,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
    );
  }
}
