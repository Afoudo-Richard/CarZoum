import 'package:flutter/material.dart';
import 'package:carzoum/src/utils/src/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.child,
    this.padding,
    this.border,
  }) : super(key: key);

  final void Function()? onPressed;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: MaterialStateProperty.all(
              padding,
            ),
            side: MaterialStateProperty.all(border),
            backgroundColor:
                MaterialStateProperty.all(backgroundColor ?? primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10),
              ),
            )),
        child: child);
  }
}
