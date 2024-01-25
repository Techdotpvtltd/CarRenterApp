import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:flutter/material.dart';

class AppManager {
  static final AppManager _instance = AppManager._internal();
  AppManager._internal() {
    debugPrint(runtimeType.toString());
  }
  factory AppManager() {
    return _instance;
  }

  void clearData() {
    UserRepo().clearAll();
  }
}
