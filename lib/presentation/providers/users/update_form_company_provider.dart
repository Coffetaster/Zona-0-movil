import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/config/helpers/utils.dart';

import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'update_form_client_provider.dart';
import 'users_provider.dart';

final updateFormCompanyProvider = StateNotifierProvider.autoDispose<
    UpdateFormCompanyNotifier, UpdateFormCompanyStatus>((ref) {
  return UpdateFormCompanyNotifier(ref.read(usersProvider.notifier));
});

class UpdateFormCompanyNotifier
    extends StateNotifier<UpdateFormCompanyStatus> {
  UpdateFormCompanyNotifier(this.usersNotifier)
      : super(UpdateFormCompanyStatus());
  final UsersNotifier usersNotifier;

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
      UpdateFormClientNotifier updateClientNotifier) async {
    try {
      updateClientNotifier.closeValidateForm();
      updateClientNotifier.invalidFormStatus();
      state = state.copyWith(
          formStatus: FormStatus.validating,
          company: GeneralInput.dirty(state.company.value),
          companyCode: NumberInput.dirty(state.companyCode.value),
          companyType: GeneralInput.dirty(state.companyType.value),
          isvalid: validateForm(),
          isFormDirty: true);

      if (!state.isvalid || !updateClientNotifier.currentState.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await usersNotifier.updateDataCompany(
          Company.fromClient(
              client: updateClientNotifier.createClient(),
              companyName: state.company.realValue,
              companyCode: state.companyCode.value.trim(),
              companyType: state.companyType.realValue));

      state = state.copyWith(formStatus: FormStatus.invalid);
      return code.toString();
    } on CustomDioError catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return Utils.getErrorsFromUpdateClientAndCompany(e.data);
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.invalid);
      return "";
    }
  }

  void initWithCompany(Company company) {
    state = state.copyWith(
      company: GeneralInput.dirty(company.company_name),
      companyCode: NumberInput.dirty(company.company_code),
      companyType: GeneralInput.dirty(company.company_type),
    );
  }
}

class UpdateFormCompanyStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final GeneralInput company;
  final NumberInput companyCode;
  final GeneralInput companyType;

  UpdateFormCompanyStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.company = const GeneralInput.pure(),
    this.companyCode = const NumberInput.pure(),
    this.companyType = const GeneralInput.pure(),
  });

  UpdateFormCompanyStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    GeneralInput? company,
    NumberInput? companyCode,
    GeneralInput? companyType,
  }) {
    return UpdateFormCompanyStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      company: company ?? this.company,
      companyCode: companyCode ?? this.companyCode,
      companyType: companyType ?? this.companyType,
    );
  }
}
