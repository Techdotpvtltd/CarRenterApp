import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {super.key, required this.url, this.onTapImage, this.errorWidget});
  final String url;
  final VoidCallback? onTapImage;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapImage,
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: (_, __, ___) =>
            errorWidget ??
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
