import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FetchEmpty extends StatelessWidget {
  const FetchEmpty({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/others/no_data.svg',
          // color: secondaryColor,
          // height: 30.h,
          width: 40.w,
        ),
        2.h.ph,
        Text(
          message ?? trans(context)!.no_data_available,
          style: TextStyle(
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
