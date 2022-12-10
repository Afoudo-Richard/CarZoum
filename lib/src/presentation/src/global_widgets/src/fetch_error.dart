import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FetchError extends StatelessWidget {
  const FetchError({
    Key? key,
    this.message,
    this.onPressedTryAgain,
  }) : super(key: key);

  final String? message;
  final void Function()? onPressedTryAgain;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/others/error.svg',
            // color: secondaryColor,
            // height: 30.h,
            width: 40.w,
          ),
          2.h.ph,
          Text(
            message ?? trans(context)!.an_error_occured_while_trying,
            style: TextStyle(
              fontSize: 15.sp,
            ),
            textAlign: TextAlign.center,
          ),
          2.h.ph,
          onPressedTryAgain != null
              ? CustomButton(
                  backgroundColor: Colors.red,
                  onPressed: onPressedTryAgain,
                  child: Text(
                    trans(context)!.retry,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
