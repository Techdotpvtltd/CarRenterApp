// ignore: dangling_library_doc_comments
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Project: 	   CarRenterApp
/// File:    	   custom_network_image
/// Path:    	   lib/utilities/widgets/custom_network_image.dart
/// Author:       Ali Akbar
/// Date:        28-02-24 15:39:43 -- Wednesday
/// Description:

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {super.key, required this.imageUrl, this.width, this.height});
  final String imageUrl;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      errorListener: (value) {},
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey,
        child:
            url != "" && error.toString().contains("No host specified in URI")
                ? Image.file(
                    File(imageUrl),
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Icon(
                      Icons.image,
                      size: 32,
                    ),
                  ),
      ),
    );
  }
}
