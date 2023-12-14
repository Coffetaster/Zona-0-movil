import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum EmailErrorInput { empty, format, personalValidation }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailErrorInput> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure({this.isRequired = true, this.personalValidation})
      : super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty(String value,
      {this.isRequired = true, this.personalValidation})
      : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;
    if (displayError == EmailErrorInput.empty)
      return AppLocalizations.of(context)!.validForm_campoRequerido;
    if (displayError == EmailErrorInput.format)
      return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    if (displayError == EmailErrorInput.personalValidation)
      return personalValidation!(value).message ?? "Error";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailErrorInput? validator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      if (isRequired)
        return EmailErrorInput.empty;
      else
        return null;
    }
    if (!emailRegExp.hasMatch(value)) return EmailErrorInput.format;
    if (personalValidation != null && !personalValidation!(value).isValid)
      return EmailErrorInput.personalValidation;
    return null;
  }

  String get realValue => value.trim();
}
