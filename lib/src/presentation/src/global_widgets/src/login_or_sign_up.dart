import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/src/utils/utils.dart';

class LoginOrSignUp extends StatelessWidget {
  const LoginOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          children: [
            6.h.ph,
            Text(
              "Please login or sign up to continue",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp),
            ),
            3.h.ph,
            CustomButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationLogoutRequested(),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            2.h.ph,
            Text(
              "Or",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
            2.h.ph,
            CustomButton(
              onPressed: () {
                Navigator.pushReplacement(context, RegistrationPage.route());
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
