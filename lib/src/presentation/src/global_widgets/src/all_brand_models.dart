import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllBrandModels extends StatelessWidget {
  const AllBrandModels({
    Key? key,
    required this.onModelItemTap,
    this.selectedItem,
  }) : super(key: key);

  final void Function(Model model)? onModelItemTap;
  final Model? selectedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<ListBrandsBloc, ListBrandsState>(
              builder: (context, state) {
                return SubItemTitle(
                  title:
                      "Select ${state.selectedBrand?.name ?? "N/A"} car model",
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
              child: BlocBuilder<ListBrandsBloc, ListBrandsState>(
                builder: (context, brandsState) {
                  return BlocBuilder<ListModelsBloc, ListModelsState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomInput(
                            inputHintText:
                                "Find ${brandsState.selectedBrand?.name ?? "N/A"} model",
                            backgroundColor: Colors.white.withOpacity(0.7),
                            labelTextStyle: const TextStyle(
                              color: primaryColor,
                            ),
                            border: Border.all(
                              color: primaryColor,
                            ),
                            onChanged: (value) {
                              BlocProvider.of<ListModelsBloc>(context).add(
                                  SearchModelChanged(
                                      text: value,
                                      brand: brandsState.selectedBrand));
                            },
                          ),
                          5.h.ph,
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              bool isSelected = selectedItem != null
                                  ? (state.models[index].objectId ==
                                          selectedItem?.objectId
                                      ? true
                                      : false)
                                  : false;
                              return GestureDetector(
                                onTap: () {
                                  onModelItemTap!(state.models[index]);
                                  Navigator.pop(context);
                                },
                                child: state.models[index].brand?.objectId ==
                                        brandsState.selectedBrand?.objectId
                                    ? SizedBox(
                                        width: 100.w,
                                        child: Text(
                                          state.models[index].name ?? "N/A",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: isSelected
                                                ? primaryColor
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return state.models[index].brand?.objectId ==
                                      brandsState.selectedBrand?.objectId
                                  ? Divider(
                                      height: 15.sp,
                                    )
                                  : const SizedBox.shrink();
                            },
                            itemCount: state.models.length,
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      );
                    },
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
