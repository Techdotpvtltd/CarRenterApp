import 'dart:io';

import 'package:beasy/models/user_model.dart';
import 'package:beasy/exceptions/auth_exceptions.dart';
import 'package:beasy/web_services/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../exceptions/exception_parsing.dart';
import '../../models/query_model.dart';
import '../../utilities/constants/constants.dart';
import '../../web_services/firestore_services.dart';
import '../../exceptions/data_exceptions.dart';
import '../validations/data_validations.dart';

class UserRepo {
  /// This class is used to get data/ request from user business layer and send
  /// to network layer.
  /// This class is used to parse user data from network layer and return back to
  /// business layer.
  ///

  static final UserRepo _instance = UserRepo._internal();
  UserModel? _userModel;
  UserModel get currentUser =>
      _userModel == null ? throw AuthExceptionUserNotFound() : _userModel!;
  bool get isUserNull => _userModel == null;

  UserRepo._internal();

  /// Promise to return instance
  factory UserRepo() => _instance;

  /// Clear all
  void clearAll() {
    _userModel = null;
  }

  /// Fetch user
  Future<void> fetch() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      debugPrint("usrr id = $userId");
      final data = await FirestoreService()
          .fetchSingleRecord(path: FIREBASE_COLLECTION_USER, docId: userId);

      if (data == null) {
        throw AuthExceptionUserNotFound();
      }

      final UserModel userModel = await UserModel.fromMap(data);
      _userModel = userModel;
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code, message: e.message);
    } on Error catch (e) {
      throw DataExceptionUnknown(message: e.toString());
    }
  }

  /// Create User Profile
  Future<void> create({
    required String uid,
    required String firstName,
    required String lastName,
    required String email,
    required UserLocation location,
  }) async {
    try {
      if (uid == "") {
        throw AuthExceptionUnAuthorized();
      }

      final UserModel user = UserModel(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        createAt: DateTime.now(),
        location: location,
      );

      final _ = await FirestoreService().saveWithDocId(
        path: FIREBASE_COLLECTION_USER,
        docId: user.uid,
        data: user.toMap(),
      );
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  //  Update user Profile ====================================
  Future<void> update({
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

      /// There is no user profile
      if (_userModel == null) {
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
        _userModel = model;
        return;
      }
      final UserModel updatedModel = _userModel!.copyWith(
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
      _userModel = updatedModel;
    } on FirebaseAuthException catch (e) {
      throw throwAuthException(errorCode: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }

  /// Upload User Profile
  Future<String> uploadProfile({required String path}) async {
    try {
      final String collectionPath =
          "$FIREBASE_COLLECTION_USER_PROFILES/${UserRepo().currentUser.uid}/${DateTime.now().microsecondsSinceEpoch}";
      return await StorageService()
          .uploadImage(withFile: File(path), collectionPath: collectionPath);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      throw e is FirebaseAuthException
          ? throwAuthException(errorCode: e.code)
          : throwDataException(errorCode: e.code);
    } catch (e) {
      debugPrint(e.toString());
      throw DataExceptionUnknown(message: e.toString());
    }
  }

  // Fetch Profile
  Future<UserModel> fetchUser({required String profileId}) async {
    try {
      final List<Map<String, dynamic>> data = await FirestoreService()
          .fetchWithMultipleConditions(
              collection: FIREBASE_COLLECTION_USER,
              queries: [
            QueryModel(field: "uid", value: profileId, type: QueryType.isEqual),
          ]);
      if (data.firstOrNull != null) {
        return UserModel.fromMap(data.first);
      }
      throw throwAuthException(errorCode: 'user-not-found');
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
