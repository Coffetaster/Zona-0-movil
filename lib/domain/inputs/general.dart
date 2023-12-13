import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum GeneralErrorInput { empty, value }

// Extend FormzInput and provide the input type and error type.
class GeneralInput extends FormzInput<String, GeneralErrorInput> {

  final bool isRequired;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const GeneralInput.pure({
    this.isRequired = true,
    this.personalValidation
  }) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const GeneralInput.dirty(String value, {
    this.isRequired = true,
    this.personalValidation
  }) : super.dirty(value);

  String? errorMessage(BuildContext context, [String? personalError]) {
    if ( isValid || isPure ) return null;
    if ( displayError == GeneralErrorInput.empty ) return AppLocalizations.of(context)!.validForm_campoRequerido;
    if ( displayError == GeneralErrorInput.value ) return personalError ?? "Error";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  GeneralErrorInput? validator(String value) {
    value = value.trim();
    if(value.isEmpty) {
      if(isRequired) return GeneralErrorInput.empty;
      else return null;
    }
    if(personalValidation != null && !personalValidation!<String>(value)) return GeneralErrorInput.value;
    return null;
  }

  String get realValue => value.trim();
}