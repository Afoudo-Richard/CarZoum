import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum VehicleBrandValidationError { empty }

class VehicleBrand extends FormzInput<String, String> {
  const VehicleBrand.pure() : super.pure('');
  const VehicleBrand.dirty([String value = '']) : super.dirty(value);

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
