import 'package:carzoum/src/presentation/src/global_widgets/src/search_input.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: trans(context)!.home,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ListBrandsBloc>(context).add(
                BrandsFetched(refresh: true),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            children: [
              // 2.h.ph,
              // const SearchInput(),
              2.h.ph,
              Text(
                trans(context)!.what_are_you_looking_for,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18.sp,
                ),
              ),
              2.h.ph,
              const CarBrands(),
              2.h.ph,

              // BlocBuilder<ListBrandsBloc, ListBrandsState>(
              //   builder: (context, state) {
              //     if (state.brands.isEmpty) {
              //       return Text("No brands loaded");
              //     }
              //     return Column(
              //       children: [
              //         Text(state.listBrandsStatus.toString()),
              //         Text(state.hasReachedMax.toString()),
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Text("${state.brands[index].name ?? "N/A"}  ");
              //           },
              //           itemCount: state.brands.length,
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // BlocBuilder<RefreshCheckerBloc, RefreshCheckerState>(
              //   builder: (context, state) {
              //     return Column(
              //       children: [
              //         Text("App configs"),
              //         Text(state.brandChangeCount.toString()),
              //         Text(state.modelChangeCount.toString()),
              //         Text(state.fuelTypeChangeCount.toString()),
              //         Text(state.conditionTypeChangeCount.toString()),
              //         Text(state.transmissionTypeCount.toString()),
              //       ],
              //     );
              //   },
              // ),
              // Text("---------------------------------"),
              // BlocBuilder<ListModelsBloc, ListModelsState>(
              //   builder: (context, state) {
              //     if (state.models.isEmpty) {
              //       return Text("No models loaded");
              //     }
              //     return Column(
              //       children: [
              //         Text(state.listModelsStatus.toString()),
              //         Text(state.hasReachedMax.toString()),
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Text(
              //                 "${state.models[index].name ?? "N/A"}  ${state.models[index].brand?.objectId ?? "N/A"}");
              //           },
              //           itemCount: state.models.length,
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // Text("---------------------------------"),
              // BlocBuilder<ListFuelTypesBloc, ListFuelTypesState>(
              //   builder: (context, state) {
              //     if (state.fuelTypes.isEmpty) {
              //       return Text("No fuelTypes loaded");
              //     }
              //     return ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return Text("${state.fuelTypes[index].name ?? "N/A"} ");
              //       },
              //       itemCount: state.fuelTypes.length,
              //     );
              //   },
              // ),
              // Text("---------------------------------"),
              // BlocBuilder<ListConditionTypesBloc, ListConditionTypesState>(
              //   builder: (context, state) {
              //     if (state.conditionTypes.isEmpty) {
              //       return Text("No condition types loaded");
              //     }
              //     return ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return Text(
              //             "${state.conditionTypes[index].name ?? "N/A"} ");
              //       },
              //       itemCount: state.conditionTypes.length,
              //     );
              //   },
              // ),
              // Text("---------------------------------"),
              // BlocBuilder<ListTransmissionTypesBloc,
              //     ListTransmissionTypesState>(
              //   builder: (context, state) {
              //     if (state.transmissionTypes.isEmpty) {
              //       return Text("No transmission types loaded");
              //     }
              //     return ListView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //         return Text(
              //             "${state.transmissionTypes[index].name ?? "N/A"} ");
              //       },
              //       itemCount: state.transmissionTypes.length,
              //     );
              //   },
              // ),
              // BlocBuilder<ListVehiclesBloc, ListVehiclesState>(
              //   builder: (context, state) {
              //     return Text(state.hasReachedMax.toString());
              //   },
              // ),
              const TrendingSection(),
              4.h.ph,
            ],
          ),
        ),
      ),
    );
  }
}
