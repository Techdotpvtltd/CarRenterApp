// ignore: dangling_library_doc_comments
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants/style_guide.dart';

/// Project: 	   CarRenterApp
/// File:    	   error_widget
/// Path:    	   lib/screens/service_provider/components/error_widget.dart
/// Author:       Ali Akbar
/// Date:        28-02-24 15:08:50 -- Wednesday
/// Description:

class CustomAlertWidget extends StatelessWidget {
  const CustomAlertWidget(
      {super.key,
      this.message,
      this.isShowRefresh = true,
      this.onPressedRefresh,
      this.width,
      this.height});
  final String? message;
  final bool isShowRefresh;
  final VoidCallback? onPressedRefresh;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth,
      height: height ?? screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              message ?? "Oops! we're facing some issues.",
              textAlign: TextAlign.center,
              style: StyleGuide.serviceProviderStyle1.copyWith(fontSize: 18),
            ),
          ),
          if (isShowRefresh)
            Column(
              children: [
                gapH20,
                RoundedButton(
                  title: "Refresh",
                  width: screenWidth * 0.5,
                  onPressed:
                      onPressedRefresh != null ? onPressedRefresh! : () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}
