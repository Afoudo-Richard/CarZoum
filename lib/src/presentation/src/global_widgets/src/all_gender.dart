import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllGender extends StatelessWidget {
  const AllGender({
    Key? key,
    required this.onGenderTap,
    this.selectedItem,
  }) : super(key: key);

  final void Function(String? gender) onGenderTap;
  final String? selectedItem;

  @override
  Widget build(BuildContext context) {
    List<String> genders = [trans(context)!.male, trans(context)!.female];

    return SizedBox(
      height: 50.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SubItemTitle(
              title: trans(context)!.select_gender,
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
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: genders.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onGenderTap(genders[index]);
                            Navigator.pop(context);
                          },
                          child: Text(
                            genders[index],
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 2.h,
                        );
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
