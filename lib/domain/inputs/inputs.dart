export 'decimal.dart';
export 'email.dart';
export 'general.dart';
export 'name.dart';
export 'number.dart';
export 'password.dart';
export 'username.dart';

/**
 * Returns true if value is correct else return false
 */
typedef PersonalValidation = bool Function<T>(T value);

enum FormStatus {
  invalid,
  valid,
  validating,
  posting
}