import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class ProfileUserItem extends StatelessWidget {
  const ProfileUserItem({
    Key? key,
    required this.icon,
    required this.title,
    this.iconContainerColor,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Color? iconContainerColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CustomContainer(
        boxShadow: [],
        backgroundColor: iconContainerColor ?? Colors.green,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
        size: 30,
      ),
    );
  }
}
