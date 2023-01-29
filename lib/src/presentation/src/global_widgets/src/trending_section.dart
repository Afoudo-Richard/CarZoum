import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubItemTitle(
          title: trans(context)!.trending,
          trailing: InkWell(
            child: Text(
              trans(context)!.see_all,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              context.read<AppBottomNavigationBarBloc>().add(
                    AppBottomNavigationBarChanged(
                      activePage: const SearchPage(),
                    ),
                  );
            },
          ),
        ),
        2.h.ph,
        BlocBuilder<ListVehiclesBloc, ListVehiclesState>(
          builder: (context, state) {
            switch (state.listVehiclesStatus) {
              case ListVehiclesStatus.initial:
              case ListVehiclesStatus.refresh:
                return const VehiclesLoading();

              case ListVehiclesStatus.failure:
                return FetchError(
                  onPressedTryAgain: () {
                    BlocProvider.of<ListVehiclesBloc>(context).add(
                      VehiclesFetched(refresh: true),
                    );
                  },
                );
              case ListVehiclesStatus.success:
                return VehicleListing(
                  vehicles: state.vehicles,
                  onScroll: () {
                    BlocProvider.of<ListVehiclesBloc>(context)
                        .add(VehiclesFetched());
                  },
                  hasReachedMax: state.hasReachedMax,
                );
            }
          },
        ),
      ],
    );
  }
}
