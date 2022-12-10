import 'package:easy_localization/easy_localization.dart';
import 'package:validators/validators.dart';
import 'package:carzoum/src/utils/utils.dart';

enum ConfirmPasswordValidationError {
  invalid,
  mismatch,
}

class ConfirmPassword extends FormzInput<String, String> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value."
        },
        {
          "validator": equals(value, password),
          "errorMessage": "Confirm password must be same as password"
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
