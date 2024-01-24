import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';

abstract class DataException extends BeasyException {
  DataException({required super.message});
}

/// Some document that we attempted to create already exists.
class DataExceptionDocAlreadyExists extends DataException {
  DataExceptionDocAlreadyExists({super.message = "Data already exists."});
}

/// The operation was cancelled (typically by the caller).
class DataExceptionCancelled extends DataException {
  DataExceptionCancelled({super.message = "The operation was cancelled."});
}

/// Internal errors
class DataExceptionInternal extends DataException {
  DataExceptionInternal({super.message = "Internal Error"});
}

/// Client specified an invalid argument.
class DataExceptionInvalidArgument extends DataException {
  DataExceptionInvalidArgument({super.message = "Invalid request."});
}

/// Some requested document was not found.
class DataExceptionNotFound extends DataException {
  DataExceptionNotFound({super.message = "Requested data was not found."});
}

/// The service is currently unavailable.
class DataExceptionUnavailable extends DataException {
  DataExceptionUnavailable(
      {super.message = "The service is currently unavailable."});
}

/// The caller does not have permission to execute the specified operation.
class DataExceptionPermissionDenialed extends DataException {
  DataExceptionPermissionDenialed(
      {super.message =
          "The user does not have permission to execute the specified operation."});
}

/// The request does not have valid authentication credentials for the operation.
class DataExceptionUnAuthenticated extends DataException {
  DataExceptionUnAuthenticated(
      {super.message =
          "The request does not have valid authentication credentials for the operation."});
}

class DataExceptionUnknown extends DataException {
  DataExceptionUnknown({required super.message});
}

DataException throwDataException({required String errorCode, String? message}) {
  switch (errorCode.toUpperCase()) {
    case 'ALREADY-EXISTS':
      return DataExceptionDocAlreadyExists();
    case 'CANCELLED':
      return DataExceptionCancelled();
    case 'INTERNAL':
      return DataExceptionInternal();
    case 'INVALID-ARGUMENT':
      return DataExceptionInvalidArgument();
    case 'NOT-FOUND':
      return DataExceptionNotFound();
    case 'PERMISSION-DENIED':
      return DataExceptionPermissionDenialed();
    case 'UNAVAILABLE':
      return DataExceptionUnavailable();
    case 'UNAUTHENTICATED':
      return DataExceptionUnAuthenticated();
    default:
      return DataExceptionUnknown(message: message ?? "Something went wrong.");
  }
}
