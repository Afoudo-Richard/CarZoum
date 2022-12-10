import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.push(context, SearchPage.route()),
      child: CustomInput(
        inputHintText: "Search car brand, model, year and more.".tr(),
        trailing: const Icon(Icons.search),
        backgroundColor: contentBackgroundColor,
        inputEnabled: false,
      ),
    );
  }
}
