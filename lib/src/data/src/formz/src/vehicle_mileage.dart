import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum VehicleMileageValidationError { empty }

class VehicleMileage extends FormzInput<String, String> {
  const VehicleMileage.pure() : super.pure('');
  const VehicleMileage.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      if (value.isEmpty) return null;
      List<Map<String, dynamic>> validators = [
        // {
        //   "validator": value.isNotEmpty,
        //   "errorMessage": "Please enter a milage.",
        // },
        {
          "validator": isNumeric(value),
          "errorMessage": "Mileage must be a number.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
