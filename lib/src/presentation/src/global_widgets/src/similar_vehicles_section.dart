import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SimilarVehiclesSection extends StatelessWidget {
  const SimilarVehiclesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: pagePadding,
          child: SubItemTitle(
            title: trans(context)!.similar_vehicles,
            trailing: InkWell(
              child: Text(
                trans(context)!.see_all,
                style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: primaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        // SizedBox(
        //   height: 35.h,
        //   child: ListView.separated(
        //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //     shrinkWrap: true,
        //     scrollDirection: Axis.horizontal,
        //     itemCount: listOfProducts.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return ProductItem(
        //         product: listOfProducts[index],
        //       );
        //     },
        //     separatorBuilder: (BuildContext context, int index) {
        //       return SizedBox(
        //         width: 5.w,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
