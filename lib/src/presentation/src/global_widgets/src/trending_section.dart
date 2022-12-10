import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubItemTitle(
          title: trans(context)!.trending,
          trailing: InkWell(
            child: Text(
              trans(context)!.see_all,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              context.read<AppBottomNavigationBarBloc>().add(
                    AppBottomNavigationBarChanged(
                      activePage: const SearchPage(),
                    ),
                  );
            },
          ),
        ),
        2.h.ph,
        const VehicleListing(),
      ],
    );
  }
}
