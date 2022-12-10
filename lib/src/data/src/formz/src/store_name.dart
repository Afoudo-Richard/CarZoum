import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum StoreNameValidationError { empty }

class StoreName extends FormzInput<String, String> {
  const StoreName.pure() : super.pure('');
  const StoreName.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please value",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
