import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carzoum/carzoum.dart';

class VehicleListing extends StatefulWidget {
  const VehicleListing(
      {super.key,
      this.isScrollable = false,
      this.minItems = 8,
      required this.vehicles,
      this.onScroll,
      required this.hasReachedMax,
      this.loadMoreScrollExtend = 0.8,
      this.paddinng,
      this.showVehicleItemActivationStatusBar = false});

  final bool isScrollable;
  final int minItems;
  final List<Vehicle> vehicles;
  final void Function()? onScroll;
  final bool hasReachedMax;
  final double loadMoreScrollExtend;
  final EdgeInsets? paddinng;
  final bool showVehicleItemActivationStatusBar;

  @override
  State<VehicleListing> createState() => _VehicleListingState();
}

class _VehicleListingState extends State<VehicleListing> {
  final _scrollController = ScrollController();
  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    bannerAd = _createBannerAd();
    bannerAd.load();
  }

  BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: AppConfigs.bannerAdTestUnitId,
      size: AdSize.mediumRectangle,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.vehicles.isEmpty
        ? const Center(
            child: FetchEmpty(
              message: "No vehicle found",
            ),
          )
        : ListView.separated(
            padding: widget.paddinng,
            itemBuilder: (context, index) {
              final vehicleItem = VehicleItem(
                showActivationStatusBar:
                    widget.showVehicleItemActivationStatusBar,
                vehicle: widget.vehicles[index],
              );
              return widget.isScrollable
                  ? (index >= widget.vehicles.length
                      ? LoadingIndicator()
                      : vehicleItem)
                  : vehicleItem;
            },
            controller: widget.isScrollable ? _scrollController : null,
            separatorBuilder: (context, index) {
              final divider = Divider(
                height: 2.h,
              );
              if (index == 0) {
                return divider;
              }
              BannerAd nativeBannerAd = _createBannerAd();
              nativeBannerAd.load();

              return index % 3 == 0
                  ? Column(
                      children: [
                        1.h.ph,
                        Container(
                          alignment: Alignment.center,
                          width: bannerAd.size.width.toDouble(),
                          height: bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: nativeBannerAd),
                        ),
                        1.h.ph,
                      ],
                    )
                  : divider;
              //       return Container(
              //   height: 200,
              //   padding: const EdgeInsets.all(10),
              //   margin: EdgeInsets.only(bottom: 20.0),
              //   child: NativeAdmob(
              //     // Your ad unit id
              //     adUnitID: AppConfigs.nativeAdvancedAdTestUnitId,
              //     controller: _nativeAdController,

              //     // Don't show loading widget when in loading state
              //     loading: Container(),
              //   ),
              // ),
              // return Divider(
              //   height: 2.h,
              // );
            },
            itemCount: widget.isScrollable
                ? (widget.hasReachedMax
                    ? widget.vehicles.length
                    : widget.vehicles.length + 1)
                : (widget.vehicles.length >= widget.minItems
                    ? widget.minItems
                    : widget.vehicles.length),
            physics: widget.isScrollable
                ? null
                : const NeverScrollableScrollPhysics(),
            shrinkWrap: widget.isScrollable == false ? true : false,
          );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.onScroll != null) {
        widget.onScroll!();
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * widget.loadMoreScrollExtend);
  }
}
