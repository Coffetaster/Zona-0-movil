import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

// Define input validation errors
enum EmailErrorInput { empty, format }

// Extend FormzInput and provide the input type and error type.
class EmailInput extends FormzInput<String, EmailErrorInput> {

  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  final bool isRequired;

  // Call super.pure to represent an unmodified form input.
  const EmailInput.pure({this.isRequired = true}) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const EmailInput.dirty(String value, {this.isRequired = true}) : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if ( isValid || isPure ) return null;
    if ( displayError == EmailErrorInput.empty ) return AppLocalizations.of(context)!.validForm_campoRequerido;
    if ( displayError == EmailErrorInput.format ) return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailErrorInput? validator(String value) {
    value = value.trim();
    if(value.isEmpty) {
      if(isRequired) return EmailErrorInput.empty;
      else return null;
    }
    if(!emailRegExp.hasMatch(value)) return EmailErrorInput.format;
    return null;
  }

  String get realValue => value.trim();
}