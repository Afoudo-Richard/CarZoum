import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:carzoum/carzoum.dart';

class JunkItApi {
  Future signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    final userStore = await createStore();

    final user = User(username: email, password: password, email: email);
    user
      ..phone = phone
      ..gender = gender
      ..firstname = firstname
      ..lastname = lastname
      ..store = userStore;

    var response = await user.signUp();

    userStore.owner = user;
    var setUserStoreResponse = await userStore.save();

    if (response.success) {
      var result = response.result;
      return true;
    } else {
      print(response.error?.message);
      throw ErrorRegistering(
        message: response.error?.message ==
                'Account already exists for this username.'
            ? 'Account already exists for this email.'
            : response.error?.message,
      );
    }
  }

  Future<Store> createStore() async {
    var store = Store();

    var response = await store.save();

    if (response.success) {
      return response.results?.first;
    } else {
      throw ErrorCreatingUserStore(message: response.error?.message);
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    final user = ParseUser(email, password, email);

    var response = await user.login();
    if (response.success) {
      var result = response.result;
      return result;
    } else {
      print(response.error?.exception.toString());

      throw ErrorLoggingIn(
        message: response.error?.message == 'Invalid username/password.'
            ? 'Invalid Email or Password.'
            : response.error?.message,
      );
    }
  }
}
