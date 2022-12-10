import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllBrandModelYears extends StatelessWidget {
  const AllBrandModelYears({
    Key? key,
    required this.onYearOfManufactureItemTap,
    this.selectedItem,
  }) : super(key: key);

  final void Function(int yearOfManufacture)? onYearOfManufactureItemTap;
  final int? selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<SellBloc, SellState>(
              builder: (context, state) {
                return SubItemTitle(
                  title:
                      "Select ${state.brand?.name ?? "N/A"}-${state.model?.name ?? "N/A"} car year",
                  trailing: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: pagePadding,
              child: BlocBuilder<SellBloc, SellState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      5.h.ph,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedItem != null
                              ? (state.model?.yearsOfManufacture![index] ==
                                      selectedItem
                                  ? true
                                  : false)
                              : false;
                          return InkWell(
                            onTap: () {
                              onYearOfManufactureItemTap!(
                                state.model?.yearsOfManufacture![index],
                              );

                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                state.model?.yearsOfManufacture![index]
                                        .toString() ??
                                    "N/A",
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
                        itemCount: state.model?.yearsOfManufacture?.length ?? 0,
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
