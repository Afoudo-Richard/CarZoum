import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_formatter/money_formatter.dart';

class VehicleDetailPage extends StatefulWidget {
  VehicleDetailPage({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Vehicle vehicle;

  static Route route(Vehicle vehicle) {
    return MaterialPageRoute<void>(
      builder: (_) => VehicleDetailPage(
        vehicle: vehicle,
      ),
    );
  }

  @override
  State<VehicleDetailPage> createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends State<VehicleDetailPage> {
  BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: AppConfigs.bannerAdTestUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            hasLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          setState(() {
            hasLoaded = false;
          });
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  bool hasLoaded = false;
  late BannerAd bannerAd;

  @override
  void initState() {
    bannerAd = _createBannerAd();
    bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehicleDetailBloc(
        vehicle: widget.vehicle,
      )..add(VehiclesDetailSimilarVehiclesFetched()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(
          title: trans(context)!.details,
          centerTitle: true,
          actions: [],
        ),
        body: SafeArea(
          child: Column(
            children: [
              hasLoaded
                  ? Container(
                      alignment: Alignment.center,
                      child: AdWidget(ad: bannerAd),
                      width: bannerAd.size.width.toDouble(),
                      height: bannerAd.size.height.toDouble(),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: SingleChildScrollView(
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImagePreviewPage(
                                              images: widget.vehicle.photos!
                                                  .map<Widget>(
                                                    (vehiclePhoto) =>
                                                        CachedNetworkImage(
                                                      fit: BoxFit.contain,
                                                      placeholder:
                                                          (context, url) =>
                                                              const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              primaryColor,
                                                          color: secondaryColor,
                                                        ),
                                                      ),
                                                      imageUrl: vehiclePhoto,
                                                    ),
                                                  )
                                                  .toList(),
                                            )));
                              },
                              child: CustomContainer(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.green,
                                width: 100.w,
                                height: 30.h,
                                // child: CachedNetworkImage(
                                //   fit: BoxFit.cover,
                                //   placeholder: (context, url) => const Center(
                                //     child: CircularProgressIndicator(
                                //       backgroundColor: primaryColor,
                                //       color: secondaryColor,
                                //     ),
                                //   ),
                                //   imageUrl: vehicle.photos![0],
                                // ),
                                child: CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: double.infinity,
                                    // aspectRatio: 16 / 9,
                                    // viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemCount: widget.vehicle.photos?.length,
                                  itemBuilder: (
                                    BuildContext context,
                                    int itemIndex,
                                    int pageViewIndex,
                                  ) =>
                                      CachedNetworkImage(
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    imageUrl: widget.vehicle.photos![itemIndex],
                                  ),
                                ),
                              ),
                            ),
                            3.h.ph,

                            Text(
                              '${widget.vehicle.brand?.name} ${widget.vehicle.model?.name} ${widget.vehicle.yearOfManufacture}',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            1.h.ph,

                            Text(
                              widget.vehicle.price!.toDouble().formatNumber(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                            1.h.ph,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Icon(
                            //               Icons.star,
                            //               color: Color(0XFFFFC120),
                            //               size: 14.sp,
                            //             ),
                            //             SizedBox(
                            //               width: 1.w,
                            //             ),
                            //             Text(
                            //               "${product.avg_rating}",
                            //               style: TextStyle(
                            //                 fontSize: 11.sp,
                            //                 fontWeight: FontWeight.w400,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         SizedBox(
                            //           width: 2.w,
                            //         ),
                            //         Text(
                            //           "${product.total_reviews} " + "reviews".tr(),
                            //           style: TextStyle(
                            //             fontSize: 11.sp,
                            //             fontWeight: FontWeight.w400,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     CustomContainer(
                            //       padding: EdgeInsets.all(6),
                            //       boxShadow: [],
                            //       backgroundColor: Colors.green.withOpacity(0.2),
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             "available".tr() +
                            //                 " : ${product.total_available}",
                            //             style: TextStyle(
                            //               color: Colors.green,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),

                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: const Color(0XFFFFC120),
                                  size: 15.sp,
                                ),
                                1.w.pw,
                                Text(
                                  widget.vehicle.location ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            2.h.ph,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.vehicle.mileage != null
                                        ? Column(
                                            children: [
                                              VehicleInfoItem(
                                                imageUrl:
                                                    'assets/images/others/icons/speedometer.png',
                                                icon: Icons.legend_toggle,
                                                title: trans(context)!.mileage,
                                                value:
                                                    '${widget.vehicle.mileage} Km',
                                              ),
                                              1.h.ph,
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    VehicleInfoItem(
                                      imageUrl:
                                          'assets/images/others/icons/manual-transmission.png',
                                      icon: Icons.card_travel,
                                      title: trans(context)!.transmission_type,
                                      value:
                                          '${widget.vehicle.transmissionType?.name}',
                                    ),
                                  ],
                                ),
                                10.w.pw,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VehicleInfoItem(
                                      imageUrl:
                                          'assets/images/others/icons/fuel-pump.png',
                                      icon: Icons.ev_station_outlined,
                                      title: trans(context)!.fuel_type,
                                      value: '${widget.vehicle.fuelType?.name}',
                                    ),
                                    1.h.ph,
                                    VehicleInfoItem(
                                      imageUrl:
                                          'assets/images/others/icons/contract.png',
                                      icon: Icons.legend_toggle,
                                      title: trans(context)!.vehicle_condition,
                                      value:
                                          '${widget.vehicle.conditionType?.name}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            2.h.ph,
                            SellerName(
                              shop_logo_image: widget
                                      .vehicle.store?.profileImage ??
                                  "https://ui-avatars.com/api/?name=${widget.vehicle.store?.name ?? widget.vehicle.user?.firstname}",
                              name: widget.vehicle.store?.name ?? "N/A",
                              isApproved: false,
                              trailing: Icon(
                                Icons.chevron_right,
                                size: 20.sp,
                              ),
                              onTap: () => Navigator.push(
                                context,
                                SellerInfoPage.route(widget.vehicle),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const Divider(),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              trans(context)!.description,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              widget.vehicle.description ?? "N/A",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      4.h.ph,
                      CustomContainer(
                        width: double.infinity,
                        padding: EdgeInsets.zero,
                        boxShadow: [],
                        backgroundColor: contentBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            const SimilarVehiclesSection(),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: paddingSize,
            vertical: 8,
          ),
          child: CallButton(
            phone: widget.vehicle.user?.phone ?? "",
          ),
        ),
      ),
    );
  }
}

class VehicleInfoItem extends StatelessWidget {
  const VehicleInfoItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.imageUrl,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String value;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Icon(
            //   Icons.legend_toggle,
            //   size: 20.sp,
            // ),
            Image.asset(
              imageUrl,
              width: 16.sp,
            ),
          ],
        ),
        2.w.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 8.sp,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}
