import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum VehicleLocationValidationError { empty }

class VehicleLocation extends FormzInput<String, String> {
  const VehicleLocation.pure() : super.pure('');
  const VehicleLocation.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a valid location.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
