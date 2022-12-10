import 'package:flutter/material.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({
    Key? key,
    this.radius = 15,
    this.color = primaryColor,
    this.strokeWidth = 2,
  }) : super(key: key);

  final double radius;
  final Color color;
  final double strokeWidth;
  final double size = 30.sp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius,
        height: radius,
        // child: CircularProgressIndicator(
        //   strokeWidth: strokeWidth,
        //   color: color,
        // ),
        child: LoadingAnimationWidget.flickr(
          leftDotColor: Colors.blue,
          rightDotColor: Colors.black,
          size: size,
        ),
      ),
    );
  }
}
