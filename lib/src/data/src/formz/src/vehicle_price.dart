import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum VehiclePriceValidationError { empty }

class VehiclePrice extends FormzInput<String, String> {
  const VehiclePrice.pure() : super.pure('');
  const VehiclePrice.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value.",
        },
        {
          "validator": isInt(value),
          "errorMessage": "Please enter a number",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
