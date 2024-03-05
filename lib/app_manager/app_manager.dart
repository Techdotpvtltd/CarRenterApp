import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/repositories/repos/mutuble_product_repo.dart';
import 'package:beasy/repositories/repos/notification_repo.dart';
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
    MutableProductRepo();
    ImmutableProductRepo().clearAll();
    NotificationRepo().clearAll();
    LocalPreferences.clearAll();
  }
}
