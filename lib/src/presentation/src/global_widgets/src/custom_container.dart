import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    this.backgroundColor,
    this.borderRadius,
    this.child,
    this.padding,
    this.margin,
    this.border,
    this.backgroundImage,
    this.width,
    this.height,
    this.boxShadow,
  }) : super(key: key);

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final DecorationImage? backgroundImage;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(10),
      margin: margin,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        image: backgroundImage,
        boxShadow: boxShadow ??
            const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 40,
                spreadRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
      ),
      child: child,
    );
  }
}
