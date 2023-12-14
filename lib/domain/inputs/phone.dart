import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum PhoneErrorInput { empty, format, personalValidation }

// Extend FormzInput and provide the input type and error type.
class PhoneInput extends FormzInput<String, PhoneErrorInput> {
  static final RegExp phoneRegExp =
      RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const PhoneInput.pure({this.isRequired = true, this.personalValidation})
      : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PhoneInput.dirty(String value,
      {this.isRequired = true, this.personalValidation})
      : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;
    if (displayError == PhoneErrorInput.empty)
      return AppLocalizations.of(context)!.validForm_campoRequerido;
    if (displayError == PhoneErrorInput.format)
      return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    if (displayError == PhoneErrorInput.personalValidation)
      return personalValidation!(value).message ?? "Error";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneErrorInput? validator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      if (isRequired)
        return PhoneErrorInput.empty;
      else
        return null;
    }
    // if (!phoneRegExp.hasMatch(value)) return PhoneErrorInput.format;
    if (personalValidation != null && !personalValidation!(value).isValid)
      return PhoneErrorInput.personalValidation;
    return null;
  }

  String get realValue => value.trim();
}
