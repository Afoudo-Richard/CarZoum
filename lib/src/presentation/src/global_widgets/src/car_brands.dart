import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CarBrands extends StatelessWidget {
  const CarBrands({super.key});

  void carBrandTap(BuildContext context, Brand? brand) {
    BlocProvider.of<AppBottomNavigationBarBloc>(context).add(
      AppBottomNavigationBarChanged(activePage: const SearchPage()),
    );
    BlocProvider.of<ListBrandsBloc>(context).add(
      BrandSelected(
        brand: brand,
      ),
    );
    BlocProvider.of<SearchFilterBloc>(context).add(
      SearchFilterVehicleBrandChanged(brand),
    );
    BlocProvider.of<SearchFilterBloc>(context).add(
      SearchFilterSubmitted(refresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBrandsBloc, ListBrandsState>(
      builder: (context, state) {
        if (state.listBrandsStatus == ListBrandsStatus.success) {
          return Builder(
            builder: (context) {
              // List<Widget> brands = [];
              var filteredBrands =
                  state.brands.where((b) => b.logo != null).toList();
              var mappedBrands = filteredBrands
                  .map((brand) {
                    return CarBrandItem(
                      title: brand.name ?? "N/A",
                      logo: brand.logoImage ??
                          "https://ui-avatars.com/api/?name=${brand.name}",
                      color: Colors.pink,
                      onTap: () {
                        // Navigator.push(context, MapLocationPage.route());
                        carBrandTap(context, brand);
                      },
                    );
                  })
                  .toList()
                  .getRange(0, 5)
                  .toList();

              // List<CarBrandItem> mappedBrands = [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SubItemTitle(
                  //   title: "Operations",
                  // ),
                  2.h.ph,
                  // MasonryGridView.count(
                  //   padding: EdgeInsets.only(
                  //     bottom: 6.h,
                  //   ),
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   crossAxisCount: 3,
                  //   mainAxisSpacing: 8,
                  //   crossAxisSpacing: 8,
                  //   itemCount: 3,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return CarBrandItem(
                  //       title: "My Trash",
                  //       icon: Icons.delete,
                  //     );
                  //   },
                  // ),
                  BlocBuilder<SearchFilterBloc, SearchFilterState>(
                    builder: (context, state) {
                      return GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: mappedBrands +
                            [
                              CarBrandItem(
                                title: trans(context)!.other,
                                logo: "",
                                icon: Icons.more_horiz,
                                color: Colors.brown,
                                onTap: () {
                                  showModalBottomSheet(
                                    barrierColor: primaryColor.withOpacity(0.7),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) {
                                      return AllBrands(
                                        onBrandItemTap: (brand) {
                                          // BlocProvider.of<SellBloc>(context).add(
                                          //   VehicleBrandChanged(brand),
                                          // );
                                          carBrandTap(context, brand);
                                        },
                                        selectedItem: state.brand,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                      );
                    },
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CarBrandItem extends StatelessWidget {
  const CarBrandItem({
    super.key,
    required this.title,
    required this.logo,
    required this.color,
    this.icon,
    this.onTap,
  });

  final String title;
  final String logo;
  final Color color;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        // margin: EdgeInsets.symmetric(
        //   horizontal: 1.h,
        //   vertical: 1.h,
        // ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircle(
              padding: EdgeInsets.all(1.sp),
              color: Colors.white,
              radius: 45.sp,
              child: icon != null
                  ? Icon(
                      icon,
                      color: primaryColor,
                      size: 30.sp,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: primaryColor,
                          color: secondaryColor,
                        ),
                      ),
                      imageUrl: logo,
                    ),
            ),
            2.h.ph,
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
