import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/extensions/shared_preferences.dart';

class AppManager {
  static final AppManager _instance = AppManager._internal();
  AppManager._internal();
  factory AppManager() {
    return _instance;
  }

  void clearData() {
    UserRepo().clearAll();
    LocalPreferences.clearAll();
  }
}
