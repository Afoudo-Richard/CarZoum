import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllTransmissionTypes extends StatelessWidget {
  const AllTransmissionTypes({
    Key? key,
    required this.onTransmissionTypeItemTap,
    this.selectedItem,
  }) : super(key: key);

  final void Function(TransmissionType transmissionType)
      onTransmissionTypeItemTap;
  final TransmissionType? selectedItem;

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
              title: "Select transmission type",
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
              child: BlocBuilder<ListTransmissionTypesBloc,
                  ListTransmissionTypesState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      5.h.ph,
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedItem != null
                              ? (state.transmissionTypes[index].objectId ==
                                      selectedItem?.objectId
                                  ? true
                                  : false)
                              : false;
                          return InkWell(
                            onTap: () {
                              onTransmissionTypeItemTap(
                                state.transmissionTypes[index],
                              );
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100.w,
                              child: Text(
                                state.transmissionTypes[index].name ?? "N/A",
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
                        itemCount: state.transmissionTypes.length,
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
