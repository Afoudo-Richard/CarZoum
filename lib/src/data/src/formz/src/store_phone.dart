import 'package:easy_localization/easy_localization.dart';
import 'package:carzoum/src/utils/utils.dart';

enum StoreWhatsappPhoneValidationError { empty }

class StoreWhatsappPhone extends FormzInput<String, String> {
  const StoreWhatsappPhone.pure() : super.pure('');
  const StoreWhatsappPhone.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter store whatsapp number",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
