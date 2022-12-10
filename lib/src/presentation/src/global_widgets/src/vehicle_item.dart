import 'package:cached_network_image/cached_network_image.dart';
import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VehicleItem extends StatelessWidget {
  const VehicleItem({
    super.key,
    required this.vehicle,
    this.showActivationStatusBar = false,
  });

  final Vehicle vehicle;
  final bool showActivationStatusBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ListVehiclesBloc>(context)
            .add(VehicleViewAdded(vehicle: vehicle));
        Navigator.push(context, VehicleDetailPage.route(vehicle));
      },
      child: CustomContainer(
        padding: EdgeInsets.zero,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
        child: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 14.h,
              child: Row(
                children: [
                  Container(
                    /////////////////// Display image container //////////////////
                    width: 33.w,
                    height: 100.h,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                              color: secondaryColor,
                            ),
                          ),
                          imageUrl: vehicle.photos?.first ??
                              "some image default image",
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: GestureDetector(
                            child: CustomContainer(
                              borderRadius: BorderRadius.circular(5.sp),
                              backgroundColor: Colors.black.withOpacity(0.3),
                              padding: EdgeInsets.all(2.sp),
                              child: Row(
                                children: [
                                  Text(
                                    "${vehicle.photos?.length}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                    size: 10.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "${vehicle.brand?.name} ${vehicle.model?.name} ${vehicle.yearOfManufacture}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              BlocBuilder<FavouriteBloc, FavouriteState>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () {
                                      state.vehicleInFavourite(vehicle)
                                          ? BlocProvider.of<FavouriteBloc>(
                                                  context)
                                              .add(FavouriteVehicleRemoved(
                                                  vehicle: vehicle))
                                          : BlocProvider.of<FavouriteBloc>(
                                                  context)
                                              .add(FavouriteVehicleAdded(
                                                  vehicle: vehicle));
                                    },
                                    child: Icon(
                                      Iconsax.star,
                                      color: state.vehicleInFavourite(vehicle)
                                          ? const Color.fromARGB(
                                              255, 255, 191, 0)
                                          : Colors.grey,
                                      size: 16.sp,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: const Color(0XFFFFC120),
                                size: 10.sp,
                              ),
                              1.w.pw,
                              Text(
                                vehicle.location ?? "N/A",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          CustomContainer(
                            backgroundColor: Colors.grey.shade200,
                            boxShadow: [],
                            padding: EdgeInsets.all(4.sp),
                            child: Text(
                              vehicle.conditionType?.name ?? "N/A",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            vehicle.price!.toDouble().formatNumber(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    padding: EdgeInsets.all(5.sp),
                    child: Text(
                      trans(context)!.chat,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const ChatDialog();
                          });
                    },
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  child: CallButton(
                    phone: vehicle.user?.phone ?? "+237 600000000",
                  ),
                ),
              ],
            ),
            showActivationStatusBar
                ? Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.sp),
                          child: BlocBuilder<MyAdvertBloc, MyAdvertState>(
                            builder: (context, state) {
                              return CustomButton(
                                backgroundColor: Colors.green,
                                child: state.advertAcceptStatus ==
                                            AdvertAcceptStatus.loading &&
                                        state.currentVehicle?.objectId ==
                                            vehicle.objectId
                                    ? LoadingIndicator()
                                    : Text(
                                        "Accept",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                onPressed: () {
                                  BlocProvider.of<MyAdvertBloc>(context).add(
                                    MyAdvertsChangeStatus(
                                      vehicle: vehicle,
                                      advertsVerificationStatus:
                                          AdvertsVerificationStatus.accept,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.sp),
                          child: BlocBuilder<MyAdvertBloc, MyAdvertState>(
                            builder: (context, state) {
                              return CustomButton(
                                backgroundColor: Colors.red,
                                child: state.advertDeclineStatus ==
                                            AdvertDeclineStatus.loading &&
                                        state.currentVehicle?.objectId ==
                                            vehicle.objectId
                                    ? LoadingIndicator()
                                    : Text(
                                        "Decline",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                onPressed: () {
                                  BlocProvider.of<MyAdvertBloc>(context).add(
                                    MyAdvertsChangeStatus(
                                      vehicle: vehicle,
                                      advertsVerificationStatus:
                                          AdvertsVerificationStatus.decline,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
