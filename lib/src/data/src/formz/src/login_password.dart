import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum LoginPasswordValidationError { empty, invalidLength }

class LoginPassword extends FormzInput<String, String> {
  const LoginPassword.pure() : super.pure('');
  const LoginPassword.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value."
        },
        // {
        //   "validator": isLength(value, 6),
        //   "errorMessage": "password_min_error".tr(),
        // },
      ];

      return validation(validators);
    }
    return null;
  }
}
