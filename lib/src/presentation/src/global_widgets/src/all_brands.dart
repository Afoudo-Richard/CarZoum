import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands(
      {Key? key,
      required this.onBrandItemTap,
      this.selectedItem,
      this.isSearch = false})
      : super(key: key);

  final void Function(Brand? brand)? onBrandItemTap;
  final Brand? selectedItem;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubItemTitle(
              title: trans(context)!.select_car_brand,
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
              child: BlocBuilder<ListBrandsBloc, ListBrandsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomInput(
                        inputHintText: trans(context)!.find_brand,
                        backgroundColor: Colors.white.withOpacity(0.7),
                        labelTextStyle: TextStyle(
                          color: primaryColor,
                        ),
                        border: Border.all(
                          color: primaryColor,
                        ),
                        onChanged: (value) {
                          BlocProvider.of<ListBrandsBloc>(context)
                              .add(SearchBrandChanged(text: value));
                        },
                      ),
                      5.h.ph,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final brand = isSearch
                              ? (index == 0
                                  ? null
                                  : state.brandsCopy[index - 1])
                              : state.brandsCopy[index];

                          bool isSelected =
                              selectedItem != null && brand != null
                                  ? (brand.objectId == selectedItem?.objectId
                                      ? true
                                      : false)
                                  : (brand == null && selectedItem == null
                                      ? true
                                      : false);

                          return InkWell(
                            onTap: () {
                              isSearch
                                  ? (index == 0
                                      ? onBrandItemTap!(null)
                                      : onBrandItemTap!(brand))
                                  : onBrandItemTap!(brand);

                              BlocProvider.of<ListBrandsBloc>(context).add(
                                BrandSelected(
                                  brand: brand,
                                ),
                              );

                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isSearch
                                        ? (index == 0
                                            ? trans(context)!.any
                                            : state.brandsCopy[index - 1]
                                                    .name ??
                                                "N/A")
                                        : state.brandsCopy[index].name ?? "N/A",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                  isSelected
                                      ? const Icon(
                                          Iconsax.tick_square,
                                          color: primaryColor,
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 15.sp,
                          );
                        },
                        itemCount: isSearch
                            ? state.brandsCopy.length + 1
                            : state.brandsCopy.length,
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
