import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: trans(context)!.search,
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<SearchFilterBloc, SearchFilterState>(
          builder: (context, state) {
            switch (state.searchFilterStatus) {
              case SearchFilterStatus.initial:
                return Center(
                  child: Text(
                    trans(context)!.what_are_you_looking_for,
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                );
              case SearchFilterStatus.refresh:
                return const VehiclesLoading(
                  padding: pagePadding,
                  itemCount: 10,
                );
              case SearchFilterStatus.success:
                return const SuccessView();
              case SearchFilterStatus.failure:
                return FetchError(
                  onPressedTryAgain: () {
                    BlocProvider.of<SearchFilterBloc>(context).add(
                      SearchFilterSubmitted(refresh: true),
                    );
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            barrierColor: primaryColor.withOpacity(0.7),
            isScrollControlled: true,
            context: context,
            builder: (ctx) {
              return const SearchFilterBottomSheet();
            },
          );
        },
        child: Icon(
          Iconsax.search_normal_14,
          size: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
