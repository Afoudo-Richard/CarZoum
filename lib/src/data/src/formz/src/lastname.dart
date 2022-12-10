import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum LastNameValidationError { empty }

class LastName extends FormzInput<String, String> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

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
