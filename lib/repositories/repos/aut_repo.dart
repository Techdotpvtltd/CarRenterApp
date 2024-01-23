import 'package:beasy/app_manager/app_manager.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/exceptions/auth_exceptions.dart';
import 'package:beasy/repositories/exceptions/data_exceptions.dart';
import 'package:beasy/repositories/validations/data_validations.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/web_services/firebase_auth_serivces.dart';
import 'package:beasy/web_services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthRepo();

  //  RegisteredAUser ====================================
  Future<void> registeredUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String confirmPassword,
      required String location}) async {
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
        location: UserLocation(attitude: 10.1, lattitude: 20.1),
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
      final UserModel updatedUser = userModel.copyWith(userType: userType);
      final _ = await FirestoreService().updateWithDocId(
          path: FIREBASE_COLLECTION_USER,
          docId: userModel.uid,
          data: updatedUser.toMap());
      AppManager().setUser = updatedUser;
    } on FirebaseException catch (e) {
      throw throwDataException(errorCode: e.code);
    }
  }
}
