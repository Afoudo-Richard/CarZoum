import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatefulWidget {
  const CallButton({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<CallButton> createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {
  bool isShowingPhone = false;
  @override
  Widget build(BuildContext context) {
    String phone = "+237${widget.phone}";
    return CustomButton(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      padding: EdgeInsets.all(5.sp),
      border: const BorderSide(color: primaryColor),
      backgroundColor: Colors.white,
      child: Text(
        isShowingPhone ? phone : trans(context)!.call,
        style: TextStyle(
          color: primaryColor,
          fontSize: 12.sp,
        ),
      ),
      onPressed: () {
        isShowingPhone
            ? launchUrl(Uri(
                scheme: "tel",
                path: phone,
              ))
            : setState(() {
                isShowingPhone = true;
              });
      },
    );
  }
}
