import 'inputs.dart';

class CustomPersonalValidation {
  static PersonalValidationResult telephonePersonalValidation(String value) {
    if (value.length == 8 &&
        int.tryParse(value) != null &&
        int.tryParse(value)! >= 0) return PersonalValidationResult.isValid();
    return PersonalValidationResult.noValid("Formato incorrecto");
  }

  static PersonalValidationResult ciPersonalValidation(String value) {
    if (value.length == 11 &&
        int.tryParse(value) != null &&
        int.tryParse(value)! >= 0) return PersonalValidationResult.isValid();
    return PersonalValidationResult.noValid("Formato incorrecto");
  }

  static PersonalValidationResult passwordPersonalValidation(String value) {
    value = value.trim();
    bool passwordRequired1 = validatePasswordRequired_Length(value);
    bool passwordRequired2 = validatePasswordRequired_Case(value);
    bool passwordRequired3 = validatePasswordRequired_Number(value);
    bool passwordRequired4 = validatePasswordRequired_EspecialChar(value);
    if (!passwordRequired1 ||
        !passwordRequired2 ||
        !passwordRequired3 ||
        !passwordRequired4) {
      return PersonalValidationResult.noValid("Contraseña insegura");
    }
    return PersonalValidationResult.isValid();
  }

  static bool validatePasswordRequired_Length(String value) =>
      value.length >= 8;
  static bool validatePasswordRequired_Case(String value) =>
      value.toLowerCase() != value && value.toUpperCase() != value;
  static bool validatePasswordRequired_Number(String value) =>
      value.contains(RegExp(r'[0-9]'));
  static bool validatePasswordRequired_EspecialChar(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[0-9]'), "")
      .replaceAll(RegExp(r'[a-z]'), "")
      .isNotEmpty;
}
