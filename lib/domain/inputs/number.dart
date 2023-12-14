import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum NumberErrorInput { empty, format, personalValidation }

// Extend FormzInput and provide the input type and error type.
class NumberInput extends FormzInput<String, NumberErrorInput> {

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const NumberInput.pure({
    this.isRequired = true,
    this.personalValidation
  }) : super.pure("");

  // Call super.dirty to represent a modified form input.
  const NumberInput.dirty(String value, {
    this.isRequired = true,
    this.personalValidation
  }) : super.dirty(value);

  String? errorMessage(BuildContext context, [String? personalError]) {
    if ( isValid || isPure ) return null;
    if ( displayError == NumberErrorInput.empty ) return AppLocalizations.of(context)!.validForm_campoRequerido;
    if ( displayError == NumberErrorInput.format ) return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    if (displayError == NumberErrorInput.personalValidation)
      return personalValidation!(value).message ?? "Error";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NumberErrorInput? validator(String value) {
    value = value.trim();
    if(value.isEmpty) {
      if(isRequired) return NumberErrorInput.empty;
      else return null;
    }
    final isInteger = int.tryParse(value);
    if(isInteger == null) return NumberErrorInput.format;
    if(personalValidation != null && !personalValidation!(value).isValid)
      return NumberErrorInput.personalValidation;
    return null;
  }

  int get realValue => int.parse(value.trim());
}