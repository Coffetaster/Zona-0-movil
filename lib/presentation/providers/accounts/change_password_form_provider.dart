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

  void toggleObscureOldPassword() {
    state = state.copyWith(isObscureOldPassword: !state.isObscureOldPassword);
  }

  void toggleObscureNewPassword() {
    state = state.copyWith(isObscureNewPassword: !state.isObscureNewPassword);
  }

  bool validateForm({
    PasswordInput? oldPassword,
    PasswordInput? newPassword,
  }) =>
      Formz.validate([
        oldPassword ?? state.oldPassword,
        newPassword ?? state.newPassword,
      ]);

  Future<String> onSubmit() async {
    try {
      state = state.copyWith(
          formStatus: FormStatus.validating,
          oldPassword: PasswordInput.dirty(state.oldPassword.value),
          newPassword: PasswordInput.dirty(state.newPassword.value,
              personalValidation:
                  CustomPersonalValidation.passwordPersonalValidation),
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
  //* req4: contener caracteres especiales
  final bool passwordRequired4;

  final bool isObscureOldPassword;
  final bool isObscureNewPassword;

  double get percentSecurePassword {
    int cant = 0;
    if (passwordRequired1) cant++;
    if (passwordRequired2) cant++;
    if (passwordRequired3) cant++;
    if (passwordRequired4) cant++;
    return cant / 4;
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
    this.passwordRequired4 = false,
    this.isObscureOldPassword = true,
    this.isObscureNewPassword = true,
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
    bool? passwordRequired4,
    bool? isObscureOldPassword,
    bool? isObscureNewPassword,
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
      passwordRequired4: passwordRequired4 ?? this.passwordRequired4,
      isObscureOldPassword: isObscureOldPassword ?? this.isObscureOldPassword,
      isObscureNewPassword: isObscureNewPassword ?? this.isObscureNewPassword,
    );
  }
}
