import 'package:beasy/main.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../../constants/style_guide.dart';

class CustomDilaogs {
  void _genericDilaog({
    required IconData icon,
    required String title,
    required String message,
    required Widget bottomWidget,
    bool barrierDismissible = true,
    Color iconColor = StyleGuide.primaryColor2,
    Color titleColor = StyleGuide.textColor2,
  }) {
    showDialog(
      context: navKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        content: Container(
          height: screenHeight * 0.40,
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6F8FE),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: iconColor,
                  ),
                ),
                gapH16,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleGuide.serviceProviderStyle2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                gapH6,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: StyleGuide.serviceProviderStyle2.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF868686),
                  ),
                ),
                gapH16,
                bottomWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void errorBox({String? message}) {
    _genericDilaog(
      icon: Icons.close,
      title: "Error",
      titleColor: Colors.red,
      message: message ?? "Error",
      iconColor: Colors.red,
      bottomWidget: RoundedButton(
        title: "Close",
        height: 50,
        onPressed: () {
          NavigationService.back(navKey.currentContext!);
        },
      ),
    );
  }

  void alertBox({
    String? message,
    String? title,
    String? negativeTitle,
    String? positiveTitle,
    VoidCallback? onNegativePressed,
    VoidCallback? onPositivePressed,
    IconData? icon,
  }) {
    _genericDilaog(
      icon: icon ?? Icons.warning,
      title: title ?? "Alert!",
      message: message ?? "Alet",
      bottomWidget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoundedButton(
            title: positiveTitle ?? "Done",
            height: 44,
            textSize: 12,
            onPressed: () {
              NavigationService.back(navKey.currentContext!);
              if (onPositivePressed != null) {
                onPositivePressed();
              }
            },
          ),
          gapH6,
          RoundedButton(
            title: negativeTitle ?? "Cancel",
            withBorderOnly: true,
            height: 44,
            textSize: 12,
            onPressed: onNegativePressed ??
                () {
                  NavigationService.back(navKey.currentContext!);
                },
          ),
        ],
      ),
    );
  }

  void deleteBox(
      {required String title,
      required String message,
      required VoidCallback onPositivePressed}) {
    alertBox(
      title: title,
      message: message,
      onPositivePressed: onPositivePressed,
      positiveTitle: "Delete",
      icon: Icons.delete,
    );
  }

  void successBox({
    String? title,
    required String message,
    VoidCallback? onPositivePressed,
    String? positiveTitle,
    bool barrierDismissible = true,
  }) {
    _genericDilaog(
      icon: Icons.check,
      title: title ?? "Success",
      barrierDismissible: barrierDismissible,
      message: message,
      bottomWidget: RoundedButton(
        title: positiveTitle ?? "Done",
        height: 50,
        onPressed: () {
          NavigationService.back(navKey.currentContext!);
          if (onPositivePressed != null) {
            onPositivePressed();
          }
        },
      ),
    );
  }
}
