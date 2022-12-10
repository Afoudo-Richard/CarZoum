import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carzoum/carzoum.dart';

class VehicleListing extends StatefulWidget {
  const VehicleListing({
    super.key,
    this.isScrollable = false,
    this.minItems = 4,
  });

  final bool isScrollable;
  final int minItems;

  @override
  State<VehicleListing> createState() => _VehicleListingState();
}

class _VehicleListingState extends State<VehicleListing> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListVehiclesBloc, ListVehiclesState>(
      builder: (context, state) {
        if (state.listVehiclesStatus == ListVehiclesStatus.initial ||
            state.listVehiclesStatus == ListVehiclesStatus.refresh) {
          return const VehiclesLoading();
        }
        if (state.listVehiclesStatus == ListVehiclesStatus.failure) {
          return FetchError(
            onPressedTryAgain: () {
              BlocProvider.of<ListVehiclesBloc>(context).add(
                VehiclesFetched(refresh: true),
              );
            },
          );
        }
        return state.vehicles.isEmpty
            ? const Center(
                child: FetchEmpty(
                  message: "No vehicle found",
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.only(
                  bottom: 30.sp,
                ),
                itemBuilder: (context, index) {
                  final articleItem = VehicleItem(
                    vehicle: state.vehicles[index],
                  );
                  return widget.isScrollable
                      ? (index >= state.vehicles.length
                          ? LoadingIndicator()
                          : articleItem)
                      : articleItem;
                },
                controller: widget.isScrollable ? _scrollController : null,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 2.h,
                  );
                },
                itemCount: widget.isScrollable
                    ? (state.hasReachedMax
                        ? state.vehicles.length
                        : state.vehicles.length + 1)
                    : (state.vehicles.length >= widget.minItems
                        ? widget.minItems
                        : state.vehicles.length),
                physics: widget.isScrollable
                    ? null
                    : const NeverScrollableScrollPhysics(),
                shrinkWrap: widget.isScrollable == false ? true : false,
              );
      },
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
      BlocProvider.of<ListVehiclesBloc>(context).add(VehiclesFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
