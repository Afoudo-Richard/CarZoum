import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class MyAdvertPage extends StatelessWidget {
  const MyAdvertPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MyAdvertPage());
  }

  void _addFetchBlocCall(BuildContext context) {
    BlocProvider.of<MyAdvertBloc>(context).add(
      MyAdvertsAllCountFetched(),
    );
    BlocProvider.of<MyAdvertBloc>(context).add(
      const MyAdvertsCategoryFetched(
        refresh: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user;
    return Scaffold(
      appBar: appBar(
        title: user?.isAdmin != null
            ? (user!.isAdmin == true
                ? trans(context)!.adverts
                : trans(context)!.my_adverts)
            : trans(context)!.my_adverts,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BlocBuilder<UserBloc, UserState>(
          //   builder: (context, state) {
          //     return Text(state.user!.isAdmin.toString());
          //   },
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: BlocBuilder<MyAdvertBloc, MyAdvertState>(
              builder: (context, state) {
                return Row(
                  children: [
                    MyAdvertSelectedCategory(
                      color: Colors.green,
                      title: "Active",
                      value: state.totalActiveVechicles.toString(),
                      isActive: state.advertStatus == AdvertStatus.active,
                      onTap: () {
                        BlocProvider.of<MyAdvertBloc>(context)
                            .add(const MyAdvertStatusChanged(
                          advertStatus: AdvertStatus.active,
                        ));

                        _addFetchBlocCall(context);
                      },
                    ),
                    MyAdvertSelectedCategory(
                      color: Colors.red,
                      title: "Declined",
                      value: state.totalDeclinedVehicles.toString(),
                      isActive: state.advertStatus == AdvertStatus.declined,
                      onTap: () {
                        BlocProvider.of<MyAdvertBloc>(context)
                            .add(const MyAdvertStatusChanged(
                          advertStatus: AdvertStatus.declined,
                        ));
                        _addFetchBlocCall(context);
                      },
                    ),
                    MyAdvertSelectedCategory(
                      color: Colors.orange,
                      title: "Reviewing",
                      value: state.totalReviewingVehicles.toString(),
                      isActive: state.advertStatus == AdvertStatus.reviewing,
                      onTap: () {
                        BlocProvider.of<MyAdvertBloc>(context)
                            .add(const MyAdvertStatusChanged(
                          advertStatus: AdvertStatus.reviewing,
                        ));
                        _addFetchBlocCall(context);
                      },
                    ),
                    MyAdvertSelectedCategory(
                      color: Colors.grey,
                      title: "Closed",
                      value: state.totalClosedVehicles.toString(),
                      isActive: state.advertStatus == AdvertStatus.closed,
                      onTap: () {
                        BlocProvider.of<MyAdvertBloc>(context)
                            .add(const MyAdvertStatusChanged(
                          advertStatus: AdvertStatus.closed,
                        ));
                        _addFetchBlocCall(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: CustomContainer(
              padding: EdgeInsets.zero,
              child: BlocBuilder<MyAdvertBloc, MyAdvertState>(
                builder: (context, state) {
                  switch (state.myAdvertFetchStatus) {
                    case MyAdvertFetchStatus.initial:
                    case MyAdvertFetchStatus.refresh:
                      return VehiclesLoading(
                        padding: EdgeInsets.only(
                          left: paddingSize,
                          right: paddingSize,
                          top: 10.sp,
                          bottom: 30.sp,
                        ),
                        itemCount: 10,
                      );
                    case MyAdvertFetchStatus.success:
                      return const MyAdvertSuccessView();
                    case MyAdvertFetchStatus.failure:
                      return FetchError(
                        onPressedTryAgain: () {
                          BlocProvider.of<MyAdvertBloc>(context).add(
                            const MyAdvertsCategoryFetched(refresh: true),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAdvertSelectedCategory extends StatelessWidget {
  const MyAdvertSelectedCategory({
    Key? key,
    required this.color,
    required this.title,
    required this.value,
    required this.isActive,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final String title;
  final String value;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          margin: EdgeInsets.symmetric(horizontal: 2.sp),
          backgroundColor:
              isActive ? color.withOpacity(0.5) : Colors.transparent,
          border: Border.all(color: color),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: isActive ? Colors.white : color,
                ),
              ),
              1.h.ph,
              Text(
                value,
                style: TextStyle(
                  fontSize: 9.sp,
                  color: isActive ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
