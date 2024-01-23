import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';

abstract class AuthException extends BeasyException {
  AuthException({required super.message, super.errorCode});
}

//  Email Already in Used ====================================

class AuthExceptionEmailAlreadyInUse extends AuthException {
  AuthExceptionEmailAlreadyInUse({
    super.message = "Email is already used by another user.",
  });
}

//  InValid Email ====================================
class AuthExceptionInvalidEmail extends AuthException {
  AuthExceptionInvalidEmail(
      {super.message = "Invalid Email.", super.errorCode = 1});
}

//  operation-not-allowe ====================================
/// Thrown if email/password accounts are not enabled.
/// Enable email/password accounts in the Firebase Console, under the Auth tab.
class AuthExceptionOperationNotAllow extends AuthException {
  AuthExceptionOperationNotAllow(
      {super.message = "Oops! We're facing backend issue."});
}

//  Week Password ====================================
class AuthExceptionWeekPassword extends AuthException {
  AuthExceptionWeekPassword(
      {super.message = "Password must be greater then 6 characters.",
      super.errorCode = 2});
}

//  Disabled User ====================================
class AuthExceptionDisabledUser extends AuthException {
  AuthExceptionDisabledUser({
    super.message = "You're not allow to login with this email.",
  });
}

//  User not found ====================================
class AuthExceptionUserNotFound extends AuthException {
  AuthExceptionUserNotFound(
      {super.message = "User not found with this email."});
}

//  Wrong Password ====================================
class AuthExceptionWrongPassword extends AuthException {
  AuthExceptionWrongPassword(
      {super.message = "Incorrect password.", super.errorCode = 2});
}

//  First Name Required ====================================
class AuthExceptionFirstNameRequired extends AuthException {
  AuthExceptionFirstNameRequired(
      {super.message = "Please enter your first name", super.errorCode = 3});
}

//  Last Name Required ====================================
class AuthExceptionLastNameRequired extends AuthException {
  AuthExceptionLastNameRequired(
      {super.message = "Please enter your Last name", super.errorCode = 4});
}

//  Email  Required ====================================
class AuthExceptionEmailRequired extends AuthException {
  AuthExceptionEmailRequired(
      {super.message = "Please enter your email.", super.errorCode = 1});
}

//  Password  Required ====================================
class AuthExceptionPasswordRequired extends AuthException {
  AuthExceptionPasswordRequired(
      {super.message = "Please enter password.", super.errorCode = 2});
}

//  Confirm Password  Required ====================================
class AuthExceptionConfirmPasswordRequired extends AuthException {
  AuthExceptionConfirmPasswordRequired(
      {super.message = "Please enter confirm password.", super.errorCode = 5});
}

//  Confirm Password doesn't matching  ====================================
class AuthExceptionConfirmPasswordDoesntMatching extends AuthException {
  AuthExceptionConfirmPasswordDoesntMatching(
      {super.message = "Password doesn't match.", super.errorCode = 5});
}

//  Location Required  ====================================
class AuthExceptionLocationRequired extends AuthException {
  AuthExceptionLocationRequired(
      {super.message = "Please select the location.", super.errorCode = 6});
}

//  Unknown Error ====================================
class AuthExceptionUnknown extends AuthException {
  AuthExceptionUnknown({required super.message});
}

AuthException throwAuthException({required String errorCode, String? message}) {
  switch (errorCode.toLowerCase()) {
    case "email-already-in-use":
      return AuthExceptionEmailAlreadyInUse();
    case 'invalid-email':
      return AuthExceptionInvalidEmail();
    case 'operation-not-allowed':
      return AuthExceptionOperationNotAllow();
    case 'weak-password':
      return AuthExceptionWeekPassword();
    default:
      return AuthExceptionUnknown(message: message ?? "Something went wrong!");
  }
}
