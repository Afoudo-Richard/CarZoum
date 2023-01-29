import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class UpdateStoreInfo extends StatelessWidget {
  const UpdateStoreInfo({
    super.key,
    this.color = Colors.orangeAccent,
    this.message,
  });

  final Color color;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      border: Border.all(
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message ?? "Update your store info",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          4.w.pw,
          CustomButton(
            backgroundColor: color,
            onPressed: () {
              Navigator.push(
                context,
                StoreDetailPage.route(),
              );
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
                letterSpacing: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
