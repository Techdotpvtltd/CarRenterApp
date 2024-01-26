import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
          imageUrl: url,
          errorWidget: (_, url, error) {
            return error.toString().contains("No host specified in URI")
                ? Image.file(
                    File(url),
                    fit: BoxFit.cover,
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return errorWidget ??
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: constraints.maxHeight / 2,
                          );
                    },
                  );
          },
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
