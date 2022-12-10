import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class SubItemTitle extends StatelessWidget {
  const SubItemTitle({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}
