import 'package:easy_localization/easy_localization.dart';
import 'package:validators/validators.dart';
import 'package:carzoum/src/utils/utils.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

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
              r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'),
          "errorMessage": "Please enter a valid email.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
