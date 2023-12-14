import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum NameErrorInput { empty, format, personalValidation }

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameErrorInput> {
  static final RegExp nameRegExp = RegExp(r"^[\p{L} ,.'-]*$",
      caseSensitive: false, unicode: true, dotAll: true);

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const NameInput.pure({this.isRequired = true, this.personalValidation})
      : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInput.dirty(String value,
      {this.isRequired = true, this.personalValidation})
      : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;
    if (displayError == NameErrorInput.empty)
      return AppLocalizations.of(context)!.validForm_campoRequerido;
    if (displayError == NameErrorInput.format)
      return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    if (displayError == NameErrorInput.personalValidation)
      return personalValidation!(value).message ?? "Error";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameErrorInput? validator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      if (isRequired)
        return NameErrorInput.empty;
      else
        return null;
    }
    if (!nameRegExp.hasMatch(value)) return NameErrorInput.format;
    if (personalValidation != null && !personalValidation!(value).isValid)
      return NameErrorInput.personalValidation;
    return null;
  }

  String get realValue => value.trim();
}
