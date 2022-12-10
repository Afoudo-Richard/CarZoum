import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum PhoneValidationError { empty }

class Phone extends FormzInput<String, String> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value.",
        },
        {
          "validator": isLength(value, 9),
          "errorMessage": "Phone must be 9 characters long.".tr(),
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
