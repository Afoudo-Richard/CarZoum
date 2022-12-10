import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum PasswordValidationError { empty, invalidLength }

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value."
        },
        {
          "validator": matches(value,
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$"),
          "errorMessage":
              "Password must contain at least: 6 characters, one uppercase, one lowercase letter, one number and one special character.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
