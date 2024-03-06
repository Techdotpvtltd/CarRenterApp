import 'package:flutter/material.dart';

class NavigationService {
  static Future<void> go(BuildContext context, Widget child) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => child));
  }

  static void off(BuildContext context, Widget child) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => child));
  }

  static void offAll(BuildContext context, Widget child) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => child), (route) => false);
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}
