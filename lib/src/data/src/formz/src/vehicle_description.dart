import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum VehicleDescriptionValidationError { empty }

class VehicleDescription extends FormzInput<String, String> {
  const VehicleDescription.pure() : super.pure('');
  const VehicleDescription.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter short vehicle description.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
