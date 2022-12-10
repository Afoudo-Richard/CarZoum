import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AboutAppPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "About App",
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: 100.h,
        child: Padding(
          padding: pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  6.h.ph,
                  AppLogo(
                    width: 50.w,
                  ),
                  2.h.ph,
                  Text(
                    trans(context)!.find_your_drive,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: primaryColor,
                    ),
                  ),
                  3.h.ph,
                  Text(
                    "Contact us: carzoum@gmail.com",
                  ),
                  1.h.ph,
                  Text(
                    "Phone: +237-672-367-020",
                  ),
                  3.h.ph,
                  Text(
                    "if you faced any problems while using our app, please try to restore it to the default settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                  4.h.ph,
                ],
              ),
              Column(
                children: [
                  Text(
                    "Version: 1.0.0",
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  2.h.ph,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
