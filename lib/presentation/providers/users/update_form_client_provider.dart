import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/data/dio/my_dio.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';

import 'users_provider.dart';

final updateFormClientProvider = StateNotifierProvider.autoDispose<
    UpdateFormClientNotifier, UpdateFormClientStatus>((ref) {
  return UpdateFormClientNotifier(ref.read(usersProvider.notifier));
});

class UpdateFormClientNotifier extends StateNotifier<UpdateFormClientStatus> {
  UpdateFormClientNotifier(this.usersNotifier)
      : super(UpdateFormClientStatus());
  final UsersNotifier usersNotifier;

  void usernameChanged(String value) {
    final username = UsernameInput.dirty(value);
    state = state.copyWith(
        username: username, isvalid: validateForm(username: username));
  }

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

  bool validateForm({
    UsernameInput? username,
    NameInput? name,
    NameInput? lastName,
    PhoneInput? telephone,
    GeneralInput? ci,
  }) =>
      Formz.validate([
        username ?? state.username,
        name ?? state.name,
        lastName ?? state.lastName,
        telephone ?? state.telephone,
        ci ?? state.ci
      ]);

  void closeValidateForm() => state = state.copyWith(
      formStatus: FormStatus.validating,
      username: UsernameInput.dirty(state.username.value),
      name: NameInput.dirty(state.name.value),
      lastName: NameInput.dirty(state.lastName.value),
      telephone: PhoneInput.dirty(state.telephone.value,
          personalValidation:
              CustomPersonalValidation.telephonePersonalValidation),
      ci: GeneralInput.dirty(state.ci.value,
          personalValidation: CustomPersonalValidation.ciPersonalValidation),
      isvalid: validateForm(),
      isFormDirty: true);

  Client createClient() => Client(
      id: state.id ?? 0,
      name: state.name.realValue,
      last_name: state.lastName.realValue,
      movil: state.telephone.value,
      ci: state.ci.realValue,
      username: state.username.realValue,
      password: '',
      email: '');

  Future<String> onSubmit() async {
    try {
      closeValidateForm();

      if (!state.isvalid) {
        state = state.copyWith(formStatus: FormStatus.invalid);
        return "412";
      }

      final code = await usersNotifier.updateDataClient(createClient());
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

  void invalidFormStatus() =>
      state = state.copyWith(formStatus: FormStatus.invalid);

  UpdateFormClientStatus get currentState => state;

  void initWithClient(Client client) {
    state = state.copyWith(
      id: () => client.id,
      username: UsernameInput.dirty(client.username),
      name: NameInput.dirty(client.name),
      lastName: NameInput.dirty(client.last_name),
      telephone: PhoneInput.dirty(client.movil),
      ci: GeneralInput.dirty(client.ci),
    );
  }

  void initWithCompany(Company company) {
    state = state.copyWith(
      id: () => company.id,
      username: UsernameInput.dirty(company.username),
      name: NameInput.dirty(company.name),
      lastName: NameInput.dirty(company.last_name),
      telephone: PhoneInput.dirty(company.movil),
      ci: GeneralInput.dirty(company.ci),
    );
  }
}

class UpdateFormClientStatus {
  final FormStatus formStatus;
  final bool isvalid;
  final bool isFormDirty;

  final int? id;

  final UsernameInput username;
  final NameInput name;
  final NameInput lastName;
  final PhoneInput telephone;
  final GeneralInput ci;

  UpdateFormClientStatus({
    this.formStatus = FormStatus.invalid,
    this.isvalid = false,
    this.isFormDirty = false,
    this.id,
    this.username = const UsernameInput.pure(),
    this.name = const NameInput.pure(),
    this.lastName = const NameInput.pure(),
    this.telephone = const PhoneInput.pure(
        personalValidation:
            CustomPersonalValidation.telephonePersonalValidation),
    this.ci = const GeneralInput.pure(
        personalValidation: CustomPersonalValidation.ciPersonalValidation),
  });

  UpdateFormClientStatus copyWith({
    FormStatus? formStatus,
    bool? isvalid,
    bool? isFormDirty,
    ValueGetter<int?>? id,
    UsernameInput? username,
    NameInput? name,
    NameInput? lastName,
    PhoneInput? telephone,
    GeneralInput? ci,
  }) {
    return UpdateFormClientStatus(
      formStatus: formStatus ?? this.formStatus,
      isvalid: isvalid ?? this.isvalid,
      isFormDirty: isFormDirty ?? this.isFormDirty,
      id: id != null ? id() : this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      telephone: telephone ?? this.telephone,
      ci: ci ?? this.ci,
    );
  }
}
