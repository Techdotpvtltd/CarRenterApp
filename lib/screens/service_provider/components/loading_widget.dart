// ignore: dangling_library_doc_comments
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

/// Project: 	   CarRenterApp
/// File:    	   loading_widget
/// Path:    	   lib/screens/service_provider/components/loading_widget.dart
/// Author:       Ali Akbar
/// Date:        28-02-24 15:08:37 -- Wednesday
/// Description:
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: StyleGuide.primaryColor2),
          gapW20,
          Text(
            "Please wait...",
            style: StyleGuide.serviceProviderStyle1.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
