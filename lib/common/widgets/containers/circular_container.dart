import 'package:flutter/material.dart';


class MOCircularContainer extends StatelessWidget {
  const MOCircularContainer({
    super.key,
    this.child,
    this.width =400,
    this.height =400,
    this.radius =400,
    this.padding =0,
    this.backgroundColor,
    this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor
      ),
    );
  }
}
