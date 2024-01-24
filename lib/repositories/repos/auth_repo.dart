import 'package:beasy/app_manager/app_manager.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/exceptions/auth_exceptions.dart';
import 'package:beasy/repositories/exceptions/data_exceptions.dart';
import 'package:beasy/repositories/validations/data_validations.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/shared_preferences.dart';
import 'package:beasy/web_services/firebase_auth_serivces.dart';
import 'package:beasy/web_services/firestore_services.dart';
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
      await fetchUser();
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
      final UserModel user = UserModel(
        uid: userCredential.user?.uid ?? email,
        firstName: firstName,
        lastName: lastName,
        email: email,
        createAt: DateTime.now(),
        location: location!,
      );

      final _ = await FirestoreService().saveWithDocId(
        path: FIREBASE_COLLECTION_USER,
        docId: user.uid,
        data: user.toMap(),
      );
      AppManager().setUser = user;
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  //  Set user type ====================================
  Future<void> setUserType({required int index}) async {
    try {
      final userModel = AppManager().user;
      final UserType userType =
          UserType.values.firstWhere((element) => element.index == index);
      final UserModel updatedUser = userModel!.copyWith(userType: userType);
      final _ = await FirestoreService().updateWithDocId(
          path: FIREBASE_COLLECTION_USER,
          docId: userModel.uid,
          data: updatedUser.toMap());
      AppManager().setUser = updatedUser;
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  //  Set user type ====================================
  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String email,
    String? imagePath,
    String? phoneNumber,
    UserLocation? userLocation,
  }) async {
    try {
      await DataValidation.updateUser(
        firstName: firstName,
        lastName: lastName,
        email: email,
        location: userLocation,
      );

      final UserModel? userModel = AppManager().user;
      if (userModel == null) {
        /// If user profile is deleted
        debugPrint("userModel is empty");
        final UserModel model = UserModel(
          uid: FirebaseAuth.instance.currentUser?.uid ?? "",
          firstName: firstName,
          lastName: lastName,
          email: email,
          location: userLocation!,
          createAt: DateTime.now(),
          phoneNumber: phoneNumber,
          imageUrl: imagePath,
        );
        await FirestoreService().saveWithDocId(
            path: FIREBASE_COLLECTION_USER,
            docId: model.uid,
            data: model.toMap());
        AppManager().setUser = model;
        return;
      }
      final UserModel updatedModel = AppManager().user!.copyWith(
            firstName: firstName,
            lastName: lastName,
            email: email,
            imageUrl: imagePath,
            location: userLocation,
            phoneNumber: phoneNumber,
          );

      await FirestoreService().updateWithDocId(
          path: FIREBASE_COLLECTION_USER,
          docId: updatedModel.uid,
          data: updatedModel.toMap());
      AppManager().setUser = updatedModel;
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  /// Fetch user
  Future<void> fetchUser() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      final data = await FirestoreService()
          .fetchSingleRecord(path: FIREBASE_COLLECTION_USER, docId: userId);

      if (data == null) {
        throw DataExceptionNotFound();
      }

      final UserModel userModel = await UserModel.fromMap(data);
      AppManager().setUser = userModel;
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code, message: e.message);
    } on Error catch (e) {
      throw DataExceptionUnknown(message: e.toString());
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
