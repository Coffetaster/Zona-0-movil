import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum DecimalErrorInput { empty, format, personalValidation }

// Extend FormzInput and provide the input type and error type.
class DecimalInput extends FormzInput<String, DecimalErrorInput> {

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const DecimalInput.pure({
    this.isRequired = true,
    this.personalValidation
  }) : super.pure("");

  // Call super.dirty to represent a modified form input.
  const DecimalInput.dirty(String value, {
    this.isRequired = true,
    this.personalValidation
  }) : super.dirty(value);

  String? errorMessage(BuildContext context, [String? personalError]) {
    if ( isValid || isPure ) return null;
    if ( displayError == DecimalErrorInput.empty ) return AppLocalizations.of(context)!.validForm_campoRequerido;
    if ( displayError == DecimalErrorInput.format ) return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    if (displayError == DecimalErrorInput.personalValidation)
      return personalValidation!(value).message ?? "Error";return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DecimalErrorInput? validator(String value) {
    value = value.trim();
    if(value.isEmpty) {
      if(isRequired) return DecimalErrorInput.empty;
      else return null;
    }
    final isDouble = double.tryParse(value);
    if(isDouble == null) return DecimalErrorInput.format;
    if(personalValidation != null && !personalValidation!(value).isValid)
      return DecimalErrorInput.personalValidation;
    return null;
  }

  double get realValue => double.parse(value.trim());
}