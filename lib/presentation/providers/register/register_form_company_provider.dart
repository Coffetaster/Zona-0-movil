import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/config/helpers/utils.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'register_form_client_provider.dart';
import 'register_provider.dart';

final registerFormCompanyProvider = StateNotifierProvider.autoDispose<
    RegisterFormCompanyNotifier, RegisterFormCompanyStatus>((ref) {
  return RegisterFormCompanyNotifier(ref.read(registerProvider.notifier));
});

class RegisterFormCompanyNotifier
    extends StateNotifier<RegisterFormCompanyStatus> {
  RegisterFormCompanyNotifier(this.registerNotifier)
      : super(RegisterFormCompanyStatus());
  final RegisterNotifier registerNotifier;

  void companyChanged(String value) {
    final company = GeneralInput.dirty(value);
    state = state.copyWith(
        company: company, isvalid: validateForm(company: company));
  }

  void companyCodeChanged(String value) {
    final companyCode = NumberInput.dirty(value);
    state = state.copyWith(
        companyCode: companyCode,
        isvalid: validateForm(companyCode: companyCode));
  }

  void companyTypeChanged(String value) {
    final companyType = GeneralInput.dirty(value);
    state = state.copyWith(
        companyType: companyType,
        isvalid: validateForm(companyType: companyType));
  }

  bool validateForm({
    GeneralInput? company,
    NumberInput? companyCode,
    GeneralInput? companyType,
  }) =>
      Formz.validate([
        company ?? state.company,
        companyCode ?? state.companyCode,
        companyType ?? state.companyType,
      ]);

  Future<String> onSubmit(
      RegisterFormClientNotifier registerClientNotifier) async {
    try {
      registerClientNotifier.closeValidateForm();
      registerClientNotifier.invalidFormStatus();
      state = state.copyWith(
          formStatus: FormStatus.validating,
          company: GeneralInput.dirty(state.company.value),
          companyCode: NumberInput.dirty(state.companyCode.value),
          companyType: GeneralInput.dirty(state.companyType.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid || !registerClientNotifier.currentState.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      if (registerClientNotifier.currentState.imagePath == null) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "499";
      }
      final code = await registerNotifier.registerCompany(
          Company.fromClient(
              client: registerClientNotifier.createClient(),
              companyName: state.company.realValue,
              companyCode: state.companyCode.value.trim(),
              companyType: state.companyType.realValue),
          registerClientNotifier.currentState.imagePath!);

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
}

class RegisterFormCompanyStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput company;
  final NumberInput companyCode;
  final GeneralInput companyType;

  RegisterFormCompanyStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.company = const GeneralInput.pure(),
    this.companyCode = const NumberInput.pure(),
    this.companyType = const GeneralInput.pure(),
  });

  RegisterFormCompanyStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? company,
    NumberInput? companyCode,
    GeneralInput? companyType,
  }) {
    return RegisterFormCompanyStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      company: company ?? this.company,
      companyCode: companyCode ?? this.companyCode,
      companyType: companyType ?? this.companyType,
    );
  }
}
