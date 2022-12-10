import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegistrationPage());
  }

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        junkItApi: RepositoryProvider.of<JunkItApi>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("User registered Successfully"),
                ),
              );
            Navigator.pushReplacement(context, LoginPage.route());
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Failed to register user'),
                ),
              );
          }
        },
        child: Scaffold(
            body: SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                tileMode: TileMode.clamp,
                colors: [
                  secondaryColor,
                  primaryColor,
                ],
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/others/car_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  8.h.ph,
                  CustomContainer(
                    backgroundColor: Colors.transparent,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/others/logo.png",
                                width: 30.w,
                              ),
                            ],
                          ),
                          3.h.ph,
                          Text(
                            trans(context)!.sign_up,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          3.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.firstname,
                                inputHintText:
                                    trans(context)!.enter_your_firstname,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (firstname) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(RegistrationFirstNameChanged(
                                            firstname)),
                                inputErrorText: state.firstname.invalid
                                    ? state.firstname.error
                                    : null,
                              );
                            },
                          ),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.lastname,
                                inputHintText: trans(context)!.enter_last_name,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (lastname) => BlocProvider.of<
                                        RegistrationBloc>(context)
                                    .add(RegistrationLastNameChanged(lastname)),
                                inputErrorText: state.lastname.invalid
                                    ? state.lastname.error
                                    : null,
                              );
                            },
                          ),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.email,
                                inputHintText:
                                    trans(context)!.enter_email_address,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (email) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(RegistrationEmailChanged(email)),
                                inputErrorText: state.email.invalid
                                    ? state.email.error
                                    : null,
                              );
                            },
                          ),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.phone,
                                inputHintText:
                                    trans(context)!.enter_phone_number,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                onChanged: (phone) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(RegistrationPhoneChanged(phone)),
                                inputErrorText: state.phone.invalid
                                    ? state.phone.error
                                    : null,
                              );
                            },
                          ),
                          // 2.h.ph,
                          // Text(
                          //   trans(context)!.select_gender,
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 12.sp,
                          //   ),
                          // ),
                          // BlocBuilder<RegistrationBloc, RegistrationState>(
                          //     builder: (context, state) {
                          //   return DropdownButton<String>(
                          //     value: state.gender.value,
                          //     isExpanded: true,
                          //     icon: const Icon(Icons.keyboard_arrow_down),
                          //     items: ['male', 'female'].map((item) {
                          //       return DropdownMenuItem<String>(
                          //         value: item,
                          //         child: Text(
                          //           item,
                          //           style: TextStyle(color: primaryColor),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: (gender) {
                          //       if (gender != null) {
                          //         BlocProvider.of<RegistrationBloc>(context)
                          //             .add(RegistrationGenderChanged(gender));
                          //       }
                          //     },
                          //   );
                          // }),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    barrierColor: primaryColor.withOpacity(0.7),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) {
                                      return AllGender(
                                        onGenderTap: (gender) {
                                          BlocProvider.of<RegistrationBloc>(
                                                  context)
                                              .add(RegistrationGenderChanged(
                                                  gender!));
                                        },
                                        selectedItem: state.gender.value,
                                      );
                                    },
                                  );
                                },
                                child: CustomInput(
                                  inputText: state.gender != null
                                      ? state.gender.value
                                      : null,
                                  inputEnabled: false,
                                  label: trans(context)!.select_gender,
                                  inputHintText: trans(context)!.select_gender,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                  labelTextStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: primaryColor,
                                    size: 20.sp,
                                  ),
                                ),
                              );
                            },
                          ),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.password,
                                inputObscureText: hidePassword,
                                inputHintText:
                                    trans(context)!.enter_account_password,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    print(hidePassword);
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  child: Icon(
                                    hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 18.sp,
                                  ),
                                ),
                                onChanged: (password) => BlocProvider.of<
                                        RegistrationBloc>(context)
                                    .add(RegistrationPasswordChanged(password)),
                                inputErrorText: state.password.invalid
                                    ? state.password.error
                                    : null,
                              );
                            },
                          ),
                          2.h.ph,
                          BlocBuilder<RegistrationBloc, RegistrationState>(
                            builder: (context, state) {
                              return CustomInput(
                                label: trans(context)!.confirm_password,
                                inputObscureText: hideConfirmPassword,
                                inputHintText:
                                    trans(context)!.confirm_your_password,
                                backgroundColor: Colors.white.withOpacity(0.7),
                                labelTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    print(hideConfirmPassword);
                                    setState(() {
                                      hideConfirmPassword =
                                          !hideConfirmPassword;
                                    });
                                  },
                                  child: Icon(
                                    hideConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 18.sp,
                                  ),
                                ),
                                onChanged: (confirmPassword) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(RegistrationConfirmPasswordChanged(
                                            confirmPassword)),
                                inputErrorText: state.confirmPassword.invalid
                                    ? state.confirmPassword.error
                                    : null,
                              );
                            },
                          ),
                          2.h.ph,
                          SizedBox(
                            width: 100.w,
                            child: BlocBuilder<RegistrationBloc,
                                RegistrationState>(
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    state.status.isValidated
                                        ? context
                                            .read<RegistrationBloc>()
                                            .add(RegistrationSubmitted())
                                        : BlocProvider.of<RegistrationBloc>(
                                                context)
                                            .add(SubmitInputsChecked());
                                  },
                                  child: state.status.isSubmissionInProgress
                                      ? LoadingIndicator(
                                          color: secondaryColor,
                                        )
                                      : Text(
                                          trans(context)!.sign_up,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          5.h.ph,
                          ListRowText(
                            leadingText:
                                trans(context)!.already_have_an_account,
                            trailingText: " " + trans(context)!.login,
                            onTapTrailingText: () {
                              Navigator.pushReplacement(
                                context,
                                LoginPage.route(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  3.h.ph,
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
