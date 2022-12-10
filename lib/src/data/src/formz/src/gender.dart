import 'package:easy_localization/easy_localization.dart';
import 'package:validators/validators.dart';
import 'package:carzoum/src/utils/utils.dart';

enum GenderValidationError { empty }

class Gender extends FormzInput<String, String> {
  const Gender.pure() : super.pure('');
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": isIn(value, ['male', 'female']),
          "errorMessage": "Please select a value".tr(),
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
