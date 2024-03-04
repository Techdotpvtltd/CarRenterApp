import 'package:beasy/exceptions/auth_exceptions.dart';
import 'package:beasy/exceptions/data_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_exceptions.dart';

/// Project: 	   CarRenterApp
/// File:    	   exception_parsing
/// Path:    	   lib/exceptions/exception_parsing.dart
/// Author:       Ali Akbar
/// Date:        27-02-24 19:00:27 -- Tuesday
/// Description:

AppException thrownAppException({required Object e}) {
  if (e is FirebaseAuthException) {
    return throwAuthException(errorCode: e.code, message: e.message);
  }

  if (e is FirebaseException) {
    return throwDataException(errorCode: e.code, message: e.toString());
  }

  if (e is AppException) {
    return e;
  }
  return DataExceptionUnknown(message: e.toString());
}
