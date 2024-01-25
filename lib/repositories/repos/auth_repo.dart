import 'package:beasy/app_manager/app_manager.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/exceptions/auth_exceptions.dart';
import 'package:beasy/repositories/exceptions/data_exceptions.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/repositories/validations/data_validations.dart';
import 'package:beasy/utilities/shared_preferences.dart';
import 'package:beasy/web_services/firebase_auth_serivces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  AuthRepo();

  //  LoginUser ====================================
  Future<void> loginUser(
      {required String withEmail, required String withPassword}) async {
    try {
      // Make Validation
      await DataValidation.loginUser(email: withEmail, password: withPassword);
      final _ = await FirebaseAuthService()
          .login(withEmail: withEmail, withPassword: withPassword);
      await UserRepo().fetch();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      throw throwDataException(errorCode: e.code, message: e.message);
    }
  }

  //  RegisteredAUser ====================================
  Future<void> registeredUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword,
      UserLocation? location}) async {
    try {
      /// Make validation
      await DataValidation.createUser(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          location: location);

      /// Create user After validation
      final UserCredential userCredential = await FirebaseAuthService()
          .registerUser(email: email, password: password);
      await UserRepo().create(
          uid: userCredential.user?.uid ?? "",
          firstName: firstName,
          lastName: lastName,
          email: email,
          location: location!);
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  /// Return Login user object
  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  /// Perform Logout
  Future<void> performLogout() async {
    await FirebaseAuthService().logoutUser();
    AppManager().clearData();
    LocalPreferences.clearAll();
  }

  /// Perform Logout
  Future<void> sendForgotPasswordEmail({required String atMail}) async {
    await FirebaseAuthService().resetPassword(email: atMail);
  }
}
