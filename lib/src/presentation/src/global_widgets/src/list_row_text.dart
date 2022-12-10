import 'package:flutter/material.dart';
import 'package:carzoum/src/utils/utils.dart';

class ListRowText extends StatelessWidget {
  const ListRowText({
    super.key,
    this.leadingText,
    this.trailingText,
    this.onTapTrailingText,
  });
  final String? leadingText;
  final String? trailingText;
  final void Function()? onTapTrailingText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        leadingText != null
            ? Text(
                leadingText!,
                style: TextStyle(
                  fontSize:
                      SizerUtil.deviceType == DeviceType.mobile ? 12.sp : 6.sp,
                  color: Colors.white,
                ),
              )
            : const SizedBox.shrink(),
        trailingText != null
            ? GestureDetector(
                onTap: onTapTrailingText,
                child: Text(
                  trailingText!,
                  style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 12.sp
                        : 6.sp,
                    color: secondaryColor,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
