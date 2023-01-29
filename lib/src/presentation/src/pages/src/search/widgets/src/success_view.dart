import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
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
      request: AdRequest(),
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
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        return state.vehicles.isEmpty
            ? const Center(
                child: FetchEmpty(
                  message: "No vehicle found",
                ),
              )
            : RefreshIndicator(
                color: primaryColor,
                onRefresh: () => Future.sync(
                  () => BlocProvider.of<SearchFilterBloc>(context).add(
                    SearchFilterSubmitted(refresh: true),
                  ),
                ),
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                    top: 10.sp,
                    bottom: 30.sp,
                  ),
                  itemBuilder: (context, index) {
                    return index >= state.vehicles.length
                        ? LoadingIndicator()
                        : VehicleItem(
                            vehicle: state.vehicles[index],
                          );
                  },
                  separatorBuilder: (context, index) {
                    final divider = Divider(
                      height: 2.h,
                    );
                    if (index == 0) {
                      return divider;
                    }
                    BannerAd nativeBannerAd = _createBannerAd();
                    nativeBannerAd.load();

                    return index % 4 == 0
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
                  },
                  itemCount: state.hasReachedMax
                      ? state.vehicles.length
                      : state.vehicles.length + 1,
                ),
              );
      },
    );
    ;
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
      BlocProvider.of<SearchFilterBloc>(context).add(
        SearchFilterSubmitted(isFromButton: false),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
