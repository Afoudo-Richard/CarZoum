import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllConditionTypes extends StatelessWidget {
  const AllConditionTypes({
    Key? key,
    required this.onConditionTypeItemTap,
    this.selectedItem,
  }) : super(key: key);

  final void Function(ConditionType conditionType) onConditionTypeItemTap;
  final ConditionType? selectedItem;

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
              title: "Select vehicle condition",
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
              child:
                  BlocBuilder<ListConditionTypesBloc, ListConditionTypesState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      5.h.ph,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedItem != null
                              ? (state.conditionTypes[index].objectId ==
                                      selectedItem?.objectId
                                  ? true
                                  : false)
                              : false;
                          return GestureDetector(
                            onTap: () {
                              onConditionTypeItemTap(
                                  state.conditionTypes[index]);
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                state.conditionTypes[index].name ?? "N/A",
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
                        itemCount: state.conditionTypes.length,
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
