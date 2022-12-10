import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:carzoum/carzoum.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const AppDrawer(),
      body:
          BlocBuilder<AppBottomNavigationBarBloc, AppBottomNavigationBarState>(
        builder: (context, state) {
          return state.activePage;
        },
      ),

      bottomNavigationBar: const AppBottomNavigationBar(),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(
      //     Icons.phone,
      //     color: secondaryColor,
      //   ),
      //   onPressed: () {
      //     launchUrl(
      //       Uri(
      //         scheme: "tel",
      //         path: "+237672367030",
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
