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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code, message: e.message);
    }
  }

  //  Login With Apple ====================================

  Future<void> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      AuthCredential authCredential = OAuthProvider("apple.com").credential(
          accessToken: credential.authorizationCode,
          idToken: credential.identityToken);
      await FirebaseAuthService()
          .loginWithCredentials(credential: authCredential);
      await UserRepo().fetch();
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    } on AuthException catch (_) {
      rethrow;
    }
  }

  //  Login With Google ====================================
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuthService().loginWithCredentials(credential: credential);
      await UserRepo().fetch();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      throw throwAuthException(errorCode: e.code);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());

      throw throwDataException(errorCode: e.code);
    } on AuthException catch (e) {
      debugPrint(e.toString());
      rethrow;
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
