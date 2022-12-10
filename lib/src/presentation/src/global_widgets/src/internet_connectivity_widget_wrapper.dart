// Flutter imports:

import 'package:carzoum/carzoum.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:connectivity_wrapper/src/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InternetConnectivityWidgetWrapper extends StatelessWidget {
  /// The [child] contained by the ConnectivityWidgetWrapper.
  final Widget child;

  /// The decoration to paint behind the [child].
  final Decoration? decoration;

  /// The disconnected color to paint behind the [child].
  final Color? disconnectedColor;

  /// The connected color to paint behind the [child].
  final Color? connectedColor;

  /// Disconnected message.
  final String? disconnectedMessage;

  /// connected message.
  final String? connectedMessage;

  /// If non-null, the style to use for this text.
  final TextStyle? messageStyle;

  /// widget height.
  final double? height;

  const InternetConnectivityWidgetWrapper({
    Key? key,
    required this.child,
    this.disconnectedColor,
    this.connectedColor,
    this.decoration,
    this.disconnectedMessage,
    this.connectedMessage,
    this.messageStyle,
    this.height,
  })  : assert(
            connectedColor == null || decoration == null,
            'Cannot provide both a connected color and a decoration\n'
            'The color argument is just a shorthand for "decoration: BoxDecoration(color: color)".'),
        assert(
            disconnectedColor == null || decoration == null,
            'Cannot provide both a disconnected color and a decoration\n'
            'The color argument is just a shorthand for "decoration: BoxDecoration(color: color)".'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isOffline = Provider.of<ConnectivityStatus>(context) !=
        ConnectivityStatus.CONNECTED;
    return Scaffold(
      body: child,
      bottomNavigationBar: AnimatedContainer(
        decoration: decoration,
        height: _isOffline ? height ?? 15.sp : 0,
        color: _isOffline
            ? disconnectedColor ?? Colors.red
            : connectedColor ?? Colors.green,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Text(
            _isOffline
                ? disconnectedMessage ?? trans(context)!.no_connection
                : connectedMessage ?? trans(context)!.back_online,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9.sp,
            ).merge(messageStyle),
          ),
        ),
      ),
    );
  }
}
