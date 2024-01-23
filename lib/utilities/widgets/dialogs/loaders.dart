import 'package:beasy/main.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class Loader {
  static final Loader _intsance = Loader._internal();
  Loader._internal();
  bool _isLoading = false;
  factory Loader() {
    return _intsance;
  }

  void show({String? withText, bool barrierDismissible = false}) {
    _isLoading = true;
    showDialog(
      context: navKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (alertContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          content: Container(
            height: 160,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(
                  color: StyleGuide.primaryColor2,
                ),
                Text(
                  withText == "" || withText == null ? "Loading.." : withText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: StyleGuide.productCardStyle1.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void hide() {
    if (_isLoading) {
      Navigator.of(navKey.currentContext!).pop();
      _isLoading = false;
    }
  }
}
