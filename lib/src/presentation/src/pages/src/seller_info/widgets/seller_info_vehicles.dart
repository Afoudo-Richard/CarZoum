import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class SellerInfoVehicles extends StatefulWidget {
  const SellerInfoVehicles({super.key});

  @override
  State<SellerInfoVehicles> createState() => _SellerInfoVehiclesState();
}

class _SellerInfoVehiclesState extends State<SellerInfoVehicles> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerInfoBloc, SellerInfoState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: paddingSize),
          itemBuilder: (context, index) {
            final vehicleItem = VehicleItem(
              vehicle: state.vehicles[index],
            );
            return index >= state.vehicles.length
                ? LoadingIndicator()
                : vehicleItem;
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 2.h,
            );
          },
          itemCount: state.hasReachedMax
              ? state.vehicles.length
              : state.vehicles.length + 1,
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
      BlocProvider.of<SellerInfoBloc>(context).add(
        SellerInfoVehiclesFetched(),
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
