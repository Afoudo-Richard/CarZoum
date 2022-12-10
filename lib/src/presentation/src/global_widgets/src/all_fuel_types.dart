import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllFuelTypes extends StatelessWidget {
  const AllFuelTypes({
    Key? key,
    required this.onFuelTypeItemTap,
    this.selectedItem,
  }) : super(key: key);
  final void Function(FuelType fuelType) onFuelTypeItemTap;
  final FuelType? selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubItemTitle(
              title: "Select fuel type",
              trailing: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: pagePadding,
              child: BlocBuilder<ListFuelTypesBloc, ListFuelTypesState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      5.h.ph,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedItem != null
                              ? (state.fuelTypes[index].objectId ==
                                      selectedItem?.objectId
                                  ? true
                                  : false)
                              : false;
                          return GestureDetector(
                            onTap: () {
                              onFuelTypeItemTap(state.fuelTypes[index]);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100.w,
                              child: Text(
                                state.fuelTypes[index].name ?? "N/A",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color:
                                      isSelected ? primaryColor : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 15.sp,
                          );
                        },
                        itemCount: state.fuelTypes.length,
                      ),
                      SizedBox(
                        height: 2.h,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
