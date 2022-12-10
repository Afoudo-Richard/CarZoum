import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';

class AllLanguages extends StatelessWidget {
  const AllLanguages({
    Key? key,
  }) : super(key: key);

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
              title: trans(context)!.language,
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
                    GestureDetector(
                      onTap: () {
                        context.locale = const Locale('en', 'US');
                        Navigator.pop(context);
                      },
                      child: Text(
                        trans(context)!.english,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    1.h.ph,
                    GestureDetector(
                      onTap: () {
                        context.locale = const Locale('fr', 'FR');
                        Navigator.pop(context);
                      },
                      child: Text(
                        trans(context)!.french,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
