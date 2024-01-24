import 'package:beasy/models/user_model.dart';
import 'package:flutter/material.dart';

class AppManager {
  static final AppManager _instance = AppManager._internal();
  AppManager._internal() {
    debugPrint(runtimeType.toString());
  }
  factory AppManager() {
    return _instance;
  }

  UserModel? _userModel;
  UserModel? get user {
    return _userModel;
  }

  set setUser(UserModel userModel) => _userModel = userModel;

  void clearData() {
    _userModel = null;
  }
}
