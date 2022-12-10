class CarZoumApiError implements Exception {
  CarZoumApiError({this.message, this.errors});
  final String? message;
  final Map<String, dynamic>? errors;

  String? get getErrorsAsString {
    var errorList = [];

    if (errors != null) {
      for (var v in errors!.values) {
        var errList = v as List;
        errorList = List.of(errorList)..addAll(errList);
      }

      return errorList.join('\n');
    }

    return null;
  }
}

class ErrorRegistering extends CarZoumApiError {
  ErrorRegistering({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorLoggingIn extends CarZoumApiError {
  ErrorLoggingIn({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorUpdatingUser extends CarZoumApiError {
  ErrorUpdatingUser({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorAddingVehicle extends CarZoumApiError {
  ErrorAddingVehicle({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorCreatingUserStore extends CarZoumApiError {
  ErrorCreatingUserStore({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorFetchingAppConfig extends CarZoumApiError {
  ErrorFetchingAppConfig({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorErrorFetchingUserStore extends CarZoumApiError {
  ErrorErrorFetchingUserStore({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorFetchingAdvertCategoryCount extends CarZoumApiError {
  ErrorFetchingAdvertCategoryCount({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorUpdatingAdvertStatus extends CarZoumApiError {
  ErrorUpdatingAdvertStatus({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}
