import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum StoreLocationValidationError { empty }

class StoreLocation extends FormzInput<String, String> {
  const StoreLocation.pure() : super.pure('');
  const StoreLocation.dirty([String value = '']) : super.dirty(value);

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
