import 'package:cached_network_image/cached_network_image.dart';
import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class SellerName extends StatelessWidget {
  const SellerName({
    Key? key,
    required this.name,
    required this.shop_logo_image,
    required this.isApproved,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final String name;
  final String shop_logo_image;
  final bool isApproved;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: CustomCircle(
          radius: 40.sp,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                color: secondaryColor,
              ),
            ),
            imageUrl: shop_logo_image,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 4.sp,
            ),
            Row(
              children: [
                Text(
                  "Official Store",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                isApproved
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.shield,
                            color: Color(0XFF3669C9),
                            size: 14.sp,
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 9.sp,
                          ),
                        ],
                      )
                    : Icon(
                        Icons.shield,
                        color: Colors.grey,
                        size: 14.sp,
                      ),
              ],
            ),
          ],
        ),
        trailing: trailing);
  }
}
