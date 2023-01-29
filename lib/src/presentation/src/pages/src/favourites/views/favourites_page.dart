import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';
import 'package:flutter_svg/svg.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const FavouritesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Favourites",
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return state.vehicles.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context)
                            .add(ClearedFavourite());
                      },
                      child: Text(
                        trans(context)!.clear,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state.vehicles.isEmpty) {
              return Center(
                child: FetchEmpty(
                  message: trans(context)!.no_favourite_added_yet,
                ),
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                    vertical: 2.h, horizontal: paddingSize),
                itemBuilder: (context, index) {
                  return VehicleItem(
                    vehicle: state.vehicles[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return 2.h.ph;
                },
                itemCount: state.vehicles.length,
              );
            }
          },
        ),
      ),
    );
  }
}
