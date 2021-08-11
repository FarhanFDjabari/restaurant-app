import 'package:flutter/material.dart';

class RestaurantAnimationContainer extends StatelessWidget {
  final AnimationController animationController;
  final Widget? child;
  final double? width, height;
  final Offset? begin, end;
  final EdgeInsetsGeometry? margin, padding;
  final BoxDecoration? decoration;

  RestaurantAnimationContainer(
      {Key? key,
      required this.animationController,
      this.begin,
      this.end,
      this.child,
      this.width,
      this.height,
      this.decoration,
      this.margin,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(animationController),
      child: FadeTransition(
        opacity: animationController,
        child: Container(
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}
