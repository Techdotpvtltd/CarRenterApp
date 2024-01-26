import 'package:beasy/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  // Notification Permission
  static Future<void> storeLaterNotificationPermission() async {
    final instance = await SharedPreferences.getInstance();
    instance.setBool("SP_LATER_NOTIFICATION_PERMISSION", true);
  }

  static Future<bool> getLaterNotificationPermission() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool("SP_LATER_NOTIFICATION_PERMISSION") ?? false;
  }

//  Location Permission ====================================

  static Future<void> storeLaterLocationPermission() async {
    final instance = await SharedPreferences.getInstance();
    instance.setBool("SP_LATER_LOCATION_PERMISSION", true);
  }

  static Future<bool> getLaterLocationPermission() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool("SP_LATER_LOCATION_PERMISSION") ?? false;
  }

  //  UserType ====================================

  static Future<void> setUserType({required int index}) async {
    final instance = await SharedPreferences.getInstance();
    instance.setInt("SP_USER_TYPE", index);
  }

  static Future<UserType> getUserType() async {
    final instance = await SharedPreferences.getInstance();
    final int index = instance.getInt("SP_USER_TYPE") ?? 0;
    return UserType.values.firstWhere((element) => element.index == index);
  }

  // Clear All
  static void clearAll() async {
    final instance = await SharedPreferences.getInstance();
    instance.clear();
  }
}
