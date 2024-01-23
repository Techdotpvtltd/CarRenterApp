import 'package:beasy/repositories/exceptions/auth_exceptions.dart';
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
      String? location}) async {
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
    if (location == null || location == "") {
      throw AuthExceptionLocationRequired();
    }
  }
}
