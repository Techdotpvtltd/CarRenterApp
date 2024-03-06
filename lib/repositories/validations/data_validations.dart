import 'package:beasy/exceptions/data_exceptions.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/exceptions/auth_exceptions.dart';
import 'package:beasy/utilities/utils.dart';

class DataValidation {
  static Future<void> loginUser({String? email, String? password}) async {
    if (email == null || email == "") {
      throw AuthExceptionEmailRequired();
    }

    if (!Util.isValidEmail(email: email)) {
      throw AuthExceptionInvalidEmail();
    }

    if (password == null || password == "") {
      throw AuthExceptionPasswordRequired();
    }
  }

  static Future<void> createUser(
      {String? firstName,
      String? lastName,
      String? password,
      String? confirmPassword,
      String? email,
      UserLocation? location}) async {
    if (firstName == null || firstName == "") {
      throw AuthExceptionFirstNameRequired();
    }

    if (lastName == null || lastName == "") {
      throw AuthExceptionLastNameRequired();
    }

    if (email == null || email == "") {
      throw AuthExceptionEmailRequired();
    }

    if (!Util.isValidEmail(email: email)) {
      throw AuthExceptionInvalidEmail();
    }

    if (password == null || password == "") {
      throw AuthExceptionPasswordRequired();
    }

    if (password.length < 6) {
      throw AuthExceptionWeekPassword();
    }

    if (confirmPassword == null || confirmPassword == "") {
      throw AuthExceptionConfirmPasswordRequired();
    }

    if (confirmPassword != password) {
      throw AuthExceptionConfirmPasswordDoesntMatching();
    }
    if (location == null) {
      throw AuthExceptionLocationRequired();
    }
  }

  static Future<void> updateUser(
      {String? firstName,
      String? lastName,
      String? email,
      UserLocation? location}) async {
    if (firstName == null || firstName == "") {
      throw AuthExceptionFirstNameRequired();
    }

    if (lastName == null || lastName == "") {
      throw AuthExceptionLastNameRequired();
    }

    if (email == null || email == "") {
      throw AuthExceptionEmailRequired();
    }

    if (!Util.isValidEmail(email: email)) {
      throw AuthExceptionInvalidEmail();
    }

    if (location == null) {
      throw AuthExceptionLocationRequired();
    }
  }

  static Future<void> product({required ProductModel productModel}) async {
    if (productModel.images.isEmpty) {
      throw DataExceptionUnknown(message: "Please upload at least one image.");
    }

    if (productModel.name.isEmpty) {
      throw DataExceptionRequiredField(errorCode: 11);
    }

    if (productModel.model.isEmpty) {
      throw DataExceptionRequiredField(errorCode: 12);
    }
    if (productModel.year == 0) {
      throw DataExceptionRequiredField(errorCode: 13);
    }

    if (productModel.price == 0) {
      throw DataExceptionRequiredField(errorCode: 14);
    }
  }
}
