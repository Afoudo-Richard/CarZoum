import 'dart:math';
import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SellerInfoPage extends StatelessWidget {
  const SellerInfoPage({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  static Route route(Vehicle vehicle) {
    return MaterialPageRoute<void>(
      builder: (_) => SellerInfoPage(
        vehicle: vehicle,
      ),
    );
  }

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerInfoBloc(user: vehicle.user ?? User())
        ..add(SellerInfoVehiclesFetched()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          title: "Seller Info",
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    SellerName(
                      shop_logo_image: vehicle.store?.profileImage ??
                          "https://ui-avatars.com/api/?name=${vehicle.store?.name ?? vehicle.user?.firstname ?? 'CarZoom'}",
                      name: vehicle.store?.name ?? "N/A",
                      isApproved: false,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Row(
                    //   children: [
                    //     Icon(LineIcons.mapMarker),
                    //     SizedBox(
                    //       width: 1.w,
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         seller.location,
                    //         style: TextStyle(
                    //           fontSize: 10.sp,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    3.h.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SellerInfoItem(
                        //   title: "Followers",
                        //   value: seller.followers.toString(),
                        // ),
                        // SellerInfoItem(
                        //   title: "Products",
                        //   value: seller.products.length.toString(),
                        // ),
                        SellerInfoItem(
                          title: "Joined",
                          value: vehicle.store?.createdAt.toString() ?? "N/A",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(),

                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomContainer(
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  boxShadow: [],
                  backgroundColor: contentBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: BlocBuilder<SellerInfoBloc, SellerInfoState>(
                    builder: (context, state) {
                      switch (state.sellerInfoListVehiclesStatus) {
                        case SellerInfoListVehiclesStatus.initial:
                        case SellerInfoListVehiclesStatus.refresh:
                          return LoadingIndicator();

                        case SellerInfoListVehiclesStatus.failure:
                          return Text("Failed to fetch data");
                        case SellerInfoListVehiclesStatus.success:
                          return const SellerInfoVehicles();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: paddingSize,
        //     vertical: 8,
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: CustomButton(
        //           backgroundColor: Colors.white,
        //           border: const BorderSide(),
        //           child: Text(
        //             "Sorting",
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 12.sp,
        //             ),
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 2.w,
        //       ),
        //       Expanded(
        //         child: CustomButton(
        //           child: Text(
        //             "Follow",
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 12.sp,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class SellerInfoItem extends StatelessWidget {
  const SellerInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Color(0XFF838589),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
