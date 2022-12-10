import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
            : ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                    top: 10.sp,
                    bottom: 30.sp),
                itemBuilder: (context, index) {
                  return index >= state.vehicles.length
                      ? LoadingIndicator()
                      : VehicleItem(
                          vehicle: state.vehicles[index],
                        );
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
