abstract class BeasyException implements Exception {
  final String message;
  final int? errorCode;

  BeasyException({required this.message, this.errorCode});
}
