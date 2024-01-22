import 'package:flutter/material.dart';

class RoundImageWidget extends StatelessWidget {
  const RoundImageWidget(
      {super.key,
      this.height,
      this.width,
      this.radius,
      required this.imageUrl,
      this.boxFit});
  final double? height;
  final double? width;
  final double? radius;
  final String imageUrl;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      height: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 10),
        ),
      ),
      child: Image.asset(
        imageUrl,
        isAntiAlias: true,
        fit: boxFit ?? BoxFit.fill,
      ),
    );
  }
}
