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
        2.h.ph,
        BlocBuilder<VehicleDetailBloc, VehicleDetailState>(
          builder: (context, state) {
            switch (state.listSimilarVehiclesStatus) {
              case ListSimilarVehiclesStatus.initial:
              case ListSimilarVehiclesStatus.refresh:
                return VehiclesLoading(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.h,
                    horizontal: paddingSize,
                  ),
                  itemCount: 10,
                );

              case ListSimilarVehiclesStatus.failure:
                return FetchError(
                  onPressedTryAgain: () {
                    BlocProvider.of<VehicleDetailBloc>(context).add(
                      VehiclesDetailSimilarVehiclesFetched(refresh: true),
                    );
                  },
                );
              case ListSimilarVehiclesStatus.success:
                // return const SellerInfoVehicles();
                return VehicleListing(
                  vehicles: state.vehicles,
                  hasReachedMax: state.hasReachedMax,
                  onScroll: () {
                    BlocProvider.of<VehicleDetailBloc>(context).add(
                      VehiclesDetailSimilarVehiclesFetched(),
                    );
                  },
                  paddinng: EdgeInsets.only(
                    left: paddingSize,
                    right: paddingSize,
                    top: 10.sp,
                    bottom: 30.sp,
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
