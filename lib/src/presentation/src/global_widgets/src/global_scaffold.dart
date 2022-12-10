import 'package:flutter/material.dart';
import 'package:carzoum/src/blocs/blocs.dart';
import 'package:carzoum/src/utils/utils.dart';

class GlobalScaffold extends StatelessWidget {
  const GlobalScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  singleScaffoldMessenger(
    context, {
    required Color backgroundColor,
    required String textMessage,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: Text(textMessage),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {},
          ),
        ],
        child: child,
      ),
    );
  }
}
