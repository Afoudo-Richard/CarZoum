import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum FirstNameValidationError { empty }

class FirstName extends FormzInput<String, String> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
