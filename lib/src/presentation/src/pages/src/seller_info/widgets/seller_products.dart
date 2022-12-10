import 'package:flutter/material.dart';

// class SellerProducts extends StatelessWidget {
//   const SellerProducts({Key? key, required this.products}) : super(key: key);

//   final List<Product> products;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: pagePadding,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: products.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.75,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         return ProductItem(
//           product: products[index],
//         );
//       },
//     );
//   }
// }
