import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:zona0_apk/main.dart';

// Define input validation errors
enum NameErrorInput { empty, format }

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameErrorInput> {

  static final RegExp nameRegExp = RegExp(r"^[\p{L} ,.'-]*$",
      caseSensitive: false, unicode: true, dotAll: true
  );

  final bool isRequired;

  // Call super.pure to represent an unmodified form input.
  const NameInput.pure({this.isRequired = true}) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInput.dirty(String value, {this.isRequired = true}) : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if ( isValid || isPure ) return null;
    if ( displayError == NameErrorInput.empty ) return AppLocalizations.of(context)!.validForm_campoRequerido;
    if ( displayError == NameErrorInput.format ) return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameErrorInput? validator(String value) {
    value = value.trim();
    if(value.isEmpty) {
      if(isRequired) return NameErrorInput.empty;
      else return null;
    }
    if(!nameRegExp.hasMatch(value)) return NameErrorInput.format;
    return null;
  }

  String get realValue => value.trim();
}