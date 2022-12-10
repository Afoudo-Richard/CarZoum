import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WishlistPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "WishList",
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: pagePadding,
          child: Column(
            children: [
              2.h.ph,
            ],
          ),
        ),
      ),
    );
  }
}
