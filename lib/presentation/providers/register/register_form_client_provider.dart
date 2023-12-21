import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'register_provider.dart';

final registerFormClientProvider = StateNotifierProvider.autoDispose<
    RegisterFormClientNotifier, RegisterFormClientStatus>((ref) {
  return RegisterFormClientNotifier(ref.read(registerProvider.notifier));
});

class RegisterFormClientNotifier
    extends StateNotifier<RegisterFormClientStatus> {
  RegisterFormClientNotifier(this.registerNotifier)
      : super(RegisterFormClientStatus());
  final RegisterNotifier registerNotifier;

  void nameChanged(String value) {
    final name = NameInput.dirty(value);
    state = state.copyWith(name: name, isvalid: validateForm(name: name));
  }

  void lastNameChanged(String value) {
    final lastName = NameInput.dirty(value);
    state = state.copyWith(
        lastName: lastName, isvalid: validateForm(lastName: lastName));
  }

  void telephoneChanged(String value) {
    final telephone = PhoneInput.dirty(value,
        personalValidation:
            CustomPersonalValidation.telephonePersonalValidation);
    state = state.copyWith(
        telephone: telephone, isvalid: validateForm(telephone: telephone));
  }

  void ciChanged(String value) {
    final ci = GeneralInput.dirty(value,
        personalValidation: CustomPersonalValidation.ciPersonalValidation);
    state = state.copyWith(ci: ci, isvalid: validateForm(ci: ci));
  }

  void usernameChanged(String value) {
    final username = UsernameInput.dirty(value);
    state = state.copyWith(
        username: username, isvalid: validateForm(username: username));
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    state = state.copyWith(email: email, isvalid: validateForm(email: email));
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value,
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
        password: password,
        passwordRequired1: passwordRequired1,
        passwordRequired2: passwordRequired2,
        passwordRequired3: passwordRequired3,
        confirmPassword: PasswordInput.dirty(state.confirmPassword.realValue,
            passwordConfirm: state.password.realValue),
        isvalid: validateForm(password: password));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword =
        PasswordInput.dirty(value, passwordConfirm: state.password.realValue);
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isvalid: validateForm(confirmPassword: confirmPassword));
  }

  void imageSelect(String? imagePath) {
    state = state.copyWith(imagePath: () => imagePath);
  }

  void toggleObscurePassword() {
    state = state.copyWith(isObscurePassword: !state.isObscurePassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
        isObscureConfirmPassword: !state.isObscureConfirmPassword);
  }

  bool validateForm({
    NameInput? name,
    NameInput? lastName,
    PhoneInput? telephone,
    GeneralInput? ci,
    UsernameInput? username,
    EmailInput? email,
    PasswordInput? password,
    PasswordInput? confirmPassword,
  }) =>
      Formz.validate([
        name ?? state.name,
        lastName ?? state.lastName,
        telephone ?? state.telephone,
        ci ?? state.ci,
        username ?? state.username,
        email ?? state.email,
        password ?? state.password,
        confirmPassword ?? state.confirmPassword
      ]);

  void closeValidateForm() => state = state.copyWith(
      formStatus: FormStatus.validating,
      name: NameInput.dirty(state.name.value),
      lastName: NameInput.dirty(state.lastName.value),
      telephone: PhoneInput.dirty(state.telephone.value,
          personalValidation:
              CustomPersonalValidation.telephonePersonalValidation),
      ci: GeneralInput.dirty(state.ci.value,
          personalValidation: CustomPersonalValidation.ciPersonalValidation),
      username: UsernameInput.dirty(state.username.value),
      email: EmailInput.dirty(state.email.value),
      password: PasswordInput.dirty(state.password.value,
          personalValidation:
              CustomPersonalValidation.passwordPersonalValidation),
      confirmPassword: PasswordInput.dirty(state.confirmPassword.value,
          passwordConfirm: state.password.realValue),
      isvalid: validateForm(),
      isFormDirty: true);

  Client createClient() => Client(
      id: 0,
      username: state.username.realValue,
      password: state.password.realValue,
      name: state.name.realValue,
      last_name: state.lastName.realValue,
      email: state.email.realValue,
      movil: state.telephone.value,
      ci: state.ci.realValue);

  Future<String> onSubmit() async {
    try {
      closeValidateForm();

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      if (state.imagePath == null) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "499";
      }

      final code = await registerNotifier.registerClient(
          createClient(), state.imagePath!);
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

  RegisterFormClientStatus get currentState => state;
}

class RegisterFormClientStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final NameInput name;
  final NameInput lastName;
  final PhoneInput telephone;
  final GeneralInput ci;
  final UsernameInput username;
  final EmailInput email;
  final PasswordInput password;
  //* req1: longitud 8 o más
  final bool passwordRequired1;
  //* req2: contener mayúscula y minúscula
  final bool passwordRequired2;
  //* req3: contener números
  final bool passwordRequired3;
  final PasswordInput confirmPassword;

  final bool isObscurePassword;
  final bool isObscureConfirmPassword;

  //*image
  final String? imagePath;

  double get percentSecurePassword {
    int cant = password.realValue.length;
    if (cant > 8) cant = 8;
    if (passwordRequired2) cant += 4;
    if (passwordRequired3) cant += 4;
    return cant / 16;
  }

  RegisterFormClientStatus(
      {this.formStatus = FormStatus.invalid,
      this.isvalid = false,
      this.isFormDirty = false,
      this.name = const NameInput.pure(),
      this.lastName = const NameInput.pure(),
      this.telephone = const PhoneInput.pure(
          personalValidation:
              CustomPersonalValidation.telephonePersonalValidation),
      this.ci = const GeneralInput.pure(
          personalValidation: CustomPersonalValidation.ciPersonalValidation),
      this.username = const UsernameInput.pure(),
      this.email = const EmailInput.pure(),
      this.password = const PasswordInput.pure(
          personalValidation:
              CustomPersonalValidation.passwordPersonalValidation),
      this.isObscurePassword = true,
      this.passwordRequired1 = false,
      this.passwordRequired2 = false,
      this.passwordRequired3 = false,
      this.confirmPassword = const PasswordInput.pure(),
      this.isObscureConfirmPassword = true,
      this.imagePath = null});

  RegisterFormClientStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    NameInput? name,
    NameInput? lastName,
    PhoneInput? telephone,
    GeneralInput? ci,
    UsernameInput? username,
    EmailInput? email,
    PasswordInput? password,
    bool? passwordRequired1,
    bool? passwordRequired2,
    bool? passwordRequired3,
    PasswordInput? confirmPassword,
    bool? isObscurePassword,
    bool? isObscureConfirmPassword,
    ValueGetter<String?>? imagePath,
  }) {
    return RegisterFormClientStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      telephone: telephone ?? this.telephone,
      ci: ci ?? this.ci,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordRequired1: passwordRequired1 ?? this.passwordRequired1,
      passwordRequired2: passwordRequired2 ?? this.passwordRequired2,
      passwordRequired3: passwordRequired3 ?? this.passwordRequired3,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
      imagePath: imagePath?.call() ?? this.imagePath,
    );
  }
}
