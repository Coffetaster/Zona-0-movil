import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'register_form_client_provider.dart';
import 'register_provider.dart';

final registerFormCompanyProvider = StateNotifierProvider.autoDispose<
    RegisterFormCompanyNotifier, RegisterFormCompanyStatus>((ref) {
  return RegisterFormCompanyNotifier(ref.read(registerProvider.notifier));
});

class RegisterFormCompanyNotifier extends StateNotifier<RegisterFormCompanyStatus> {
  RegisterFormCompanyNotifier(this.registerNotifier)
      : super(RegisterFormCompanyStatus());
  final RegisterNotifier registerNotifier;

  void companyChanged(String value) {
    final company = GeneralInput.dirty(value);
    state = state.copyWith(
        company: company, isvalid: validateForm(company: company));
  }

  void companyCodeChanged(String value) {
    final companyCode = GeneralInput.dirty(value);
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
    GeneralInput? companyCode,
    GeneralInput? companyType,
  }) =>
      Formz.validate([
        company ?? state.company,
        companyCode ?? state.companyCode,
        companyType ?? state.companyType,
      ]);

  Future<int> onSubmit(RegisterFormClientNotifier registerClientNotifier) async {
    registerClientNotifier.closeValidateForm();
    state = state.copyWith(
        formStatus: FormStatus.validating,
        company: GeneralInput.dirty(state.company.value),
        companyCode: GeneralInput.dirty(state.companyCode.value),
        companyType: GeneralInput.dirty(state.companyType.value),
        isvalid: validateForm(),
        isFormDirty: true);

    if (!state.isvalid || !registerClientNotifier.currentState.isvalid) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return 412;
    }

    try {
      await registerNotifier.registerCompany(Company.fromClient(
          client: registerClientNotifier.createClient(),
          companyName: state.company.realValue,
          companyCode: state.companyCode.realValue,
          companyType: state.companyType.realValue,));

      state = state.copyWith(formStatus: FormStatus.invalid);
      return 200;
    } on CustomDioError catch (e) {
      return e.code;
    } catch (e) {
      return 400;
    }
  }
}

class RegisterFormCompanyStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput company;
  final GeneralInput companyCode;
  final GeneralInput companyType;

  RegisterFormCompanyStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.company = const GeneralInput.pure(),
    this.companyCode = const GeneralInput.pure(),
    this.companyType = const GeneralInput.pure(),
  });

  RegisterFormCompanyStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? company,
    GeneralInput? companyCode,
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
