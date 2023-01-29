import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sizer/sizer.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubItemTitle(
              title: "Search & Sort",
              trailing: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  LineIcons.times,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: TabBar(
                    labelPadding: EdgeInsets.only(bottom: 10),
                    indicatorColor: primaryColor,
                    tabs: [
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Sort",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    Filter(),
                    Sort(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingSize,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor: Colors.white,
                    border: const BorderSide(),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<SearchFilterBloc>(context).add(
                        SearchFilterResetted(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      BlocProvider.of<SearchFilterBloc>(context).add(
                        SearchFilterSubmitted(refresh: true),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedRange = const RangeValues(1884, 2022);
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            barrierColor: primaryColor.withOpacity(0.7),
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) {
                              return AllBrands(
                                isSearch: true,
                                onBrandItemTap: (brand) {
                                  print(brand);
                                  BlocProvider.of<SearchFilterBloc>(context)
                                      .add(
                                    SearchFilterVehicleBrandChanged(brand),
                                  );
                                },
                                selectedItem: state.brand,
                              );
                            },
                          );
                        },
                        child: CustomInput(
                          inputText:
                              state.brand != null ? state.brand!.name : null,
                          inputEnabled: false,
                          label: "Brand",
                          inputHintText: "Select Car brand",
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: primaryColor,
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: primaryColor,
                            size: 20.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          state.brand != null
                              ? showModalBottomSheet(
                                  barrierColor: primaryColor.withOpacity(0.7),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (ctx) {
                                    return AllBrandModels(
                                      onModelItemTap: (model) {
                                        BlocProvider.of<SearchFilterBloc>(
                                                context)
                                            .add(
                                          SearchFilterVehicleModelChanged(
                                              model),
                                        );
                                      },
                                      selectedItem: state.model,
                                    );
                                  },
                                )
                              : print("Select brand model");
                        },
                        child: CustomInput(
                          inputText:
                              state.model != null ? state.model!.name : null,
                          inputEnabled: false,
                          label: "Model",
                          inputHintText: "Select brand model",
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: primaryColor,
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: primaryColor,
                            size: 20.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          1.h.ph,
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: primaryColor.withOpacity(0.7),
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) {
                                  return AllFuelTypes(
                                    onFuelTypeItemTap: (fuelType) {
                                      BlocProvider.of<SearchFilterBloc>(context)
                                          .add(
                                        SearchFilterVehicleFuelTypeChanged(
                                            fuelType),
                                      );
                                    },
                                    selectedItem: state.fuelType,
                                  );
                                },
                              );
                            },
                            child: CustomInput(
                              inputText: state.fuelType != null
                                  ? state.fuelType!.name
                                  : null,
                              inputEnabled: false,
                              label: "Fuel Type",
                              inputHintText: "Select fuel type",
                              backgroundColor: Colors.white.withOpacity(0.7),
                              labelTextStyle: TextStyle(
                                color: primaryColor,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          1.h.ph,
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: primaryColor.withOpacity(0.7),
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) {
                                  return AllTransmissionTypes(
                                    onTransmissionTypeItemTap:
                                        (transmissionType) {
                                      BlocProvider.of<SearchFilterBloc>(context)
                                          .add(
                                        SearchFilterVehicleTransmissionTypeChanged(
                                          transmissionType,
                                        ),
                                      );
                                    },
                                    selectedItem: state.transmissionType,
                                  );
                                },
                              );
                            },
                            child: CustomInput(
                              inputText: state.transmissionType != null
                                  ? state.transmissionType!.name
                                  : null,
                              inputEnabled: false,
                              label: "Transmission Type",
                              inputHintText: "Select transmission type",
                              backgroundColor: Colors.white.withOpacity(0.7),
                              labelTextStyle: TextStyle(
                                color: primaryColor,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          1.h.ph,
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: primaryColor.withOpacity(0.7),
                                isScrollControlled: true,
                                context: context,
                                builder: (ctx) {
                                  return AllConditionTypes(
                                    onConditionTypeItemTap: (conditionType) {
                                      BlocProvider.of<SearchFilterBloc>(context)
                                          .add(
                                        SearchFilterVehicleConditionTypeChanged(
                                          conditionType,
                                        ),
                                      );
                                    },
                                    selectedItem: state.conditionType,
                                  );
                                },
                              );
                            },
                            child: CustomInput(
                              inputText: state.conditionType != null
                                  ? state.conditionType!.name
                                  : null,
                              inputEnabled: false,
                              label: "Condition",
                              inputHintText: "Select condition",
                              backgroundColor: Colors.white.withOpacity(0.7),
                              labelTextStyle: TextStyle(
                                color: primaryColor,
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: primaryColor,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Year of manufacturer",
                            style: inputLabelTextStyle,
                          ),
                          1.h.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From ${state.startYearOfManufacture}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "To ${state.endYearOfManufacture}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorColor: Colors
                                  .blue, // This is what you are asking for
                              inactiveTrackColor:
                                  Color(0xFF8D8E98), // Custom Gray Color
                              activeTrackColor: Colors.white,
                              thumbColor: Colors.red,
                              overlayColor: secondaryColor.withOpacity(
                                  0.6), // Custom Thumb overlay Color
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 12.0,
                              ),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: RangeSlider(
                              activeColor: primaryColor,
                              values: RangeValues(
                                state.startYearOfManufacture.toDouble(),
                                state.endYearOfManufacture.toDouble(),
                              ),
                              onChanged: (RangeValues range) {
                                BlocProvider.of<SearchFilterBloc>(context).add(
                                  SearchFilterVehicleYearOfManufactureChanged(
                                    startYear: range.start.toInt(),
                                    endYear: range.end.toInt(),
                                  ),
                                );
                              },
                              min: state.initialStartYearOfManufacuture
                                  .toDouble(),
                              max: state.initialEndYearOfManufacture.toDouble(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mileage",
                            style: inputLabelTextStyle,
                          ),
                          1.h.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From ${state.startMileage.formatNumber(
                                  symbol: '',
                                )}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "To ${state.endMileage.formatNumber(
                                  symbol: '',
                                )}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorColor: Colors
                                  .blue, // This is what you are asking for
                              inactiveTrackColor:
                                  Color(0xFF8D8E98), // Custom Gray Color
                              activeTrackColor: Colors.white,
                              thumbColor: Colors.red,
                              overlayColor: secondaryColor.withOpacity(
                                  0.6), // Custom Thumb overlay Color
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: RangeSlider(
                              activeColor: primaryColor,
                              values: RangeValues(
                                state.startMileage.toDouble(),
                                state.endMileage.toDouble(),
                              ),
                              onChanged: (RangeValues range) {
                                BlocProvider.of<SearchFilterBloc>(context).add(
                                  SearchFilterVehicleMileageRangeChanged(
                                    startMileage: range.start.toInt(),
                                    endMileage: range.end.toInt(),
                                  ),
                                );
                              },
                              min: state.initialStartMileage.toDouble(),
                              max: state.initialEndMileage.toDouble(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: inputLabelTextStyle,
                          ),
                          1.h.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ${selectedRange.start.formatNumber()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                " ${selectedRange.end.formatNumber()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorColor: Colors
                                  .blue, // This is what you are asking for
                              inactiveTrackColor:
                                  Color(0xFF8D8E98), // Custom Gray Color
                              activeTrackColor: Colors.white,
                              thumbColor: Colors.red,
                              overlayColor: secondaryColor.withOpacity(
                                  0.6), // Custom Thumb overlay Color
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: RangeSlider(
                              activeColor: primaryColor,
                              values: selectedRange,
                              onChanged: (RangeValues newRange) {
                                // setState(() {
                                //   selectedRange = newRange;
                                // });
                              },
                              min: 1884,
                              max: 2022,
                              labels: RangeLabels('${selectedRange.start}',
                                  '${selectedRange.end}'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  1.h.ph,
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vehicle is registered",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              activeColor: Colors.green,
                              value: state.isRegistered == null
                                  ? false
                                  : state.isRegistered,
                              onChanged: (value) {
                                BlocProvider.of<SearchFilterBloc>(context).add(
                                  SearchFilterVehicleIsRegisteredChanged(
                                    value!,
                                  ),
                                );
                              }),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vehicle price is negotiable",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            activeColor: Colors.green,
                            value: state.isNegotiable == null
                                ? false
                                : state.isNegotiable,
                            onChanged: (value) {
                              BlocProvider.of<SearchFilterBloc>(context).add(
                                SearchFilterVehicleIsNegotiableChanged(
                                  value!,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Sort extends StatelessWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: pagePadding,
          child: Column(
            children: const [
              SortItem(label: "Name (A-Z)"),
              SortItem(label: "Name (Z-A)"),
              SortItem(label: "Price (High-Low)"),
              SortItem(label: "Price (Low-High)"),
            ],
          )),
    );
  }
}

class SortItem extends StatefulWidget {
  const SortItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  State<SortItem> createState() => _SortItemState();
}

class _SortItemState extends State<SortItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              isChecked
                  ? const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Icon(
                        LineIcons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const Divider(
            height: 30,
          ),
        ],
      ),
    );
  }
}
