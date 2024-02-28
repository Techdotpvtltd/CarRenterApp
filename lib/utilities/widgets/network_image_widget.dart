import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/style_guide.dart';

class CircleNetworkImage extends StatelessWidget {
  const CircleNetworkImage(
      {super.key, required this.url, this.onTapImage, this.errorWidget});
  final String url;
  final VoidCallback? onTapImage;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapImage,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: StyleGuide.primaryColor2,
          borderRadius: BorderRadius.all(
            Radius.circular(300),
          ),
        ),
        child: CustomNetworkImage(
          imageUrl: url,
        ),
      ),
    );
  }
}
