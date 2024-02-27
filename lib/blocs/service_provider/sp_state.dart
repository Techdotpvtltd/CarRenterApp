import 'package:beasy/exceptions/app_exceptions.dart';

abstract class SPState {
  final bool isLoading;
  final String loadingText;

  SPState({this.isLoading = false, this.loadingText = ""});
}

class SPStateInitialize extends SPState {
  SPStateInitialize({super.isLoading = false});
}

class SPStateUninitialize extends SPState {
  SPStateUninitialize({super.isLoading = false});
}

/// Creating Service State
class SPStateCreatingProduct extends SPState {
  SPStateCreatingProduct(
      {super.isLoading = true, super.loadingText = "Creating Product."});
}

/// CreateProductFailure
class SPStateCreateProductFailure extends SPState {
  final AppException exception;

  SPStateCreateProductFailure(
      {super.isLoading = false, required this.exception});
}

/// CreateProductSuccess
class SPStateCreatedProduct extends SPState {}

/// Uploading Images State
class SPStateUploadingImage extends SPState {
  SPStateUploadingImage(
      {super.isLoading = true, super.loadingText = "Uploading images."});
}

/// Uploading Images failure
class SPStateUploadImageFailure extends SPState {
  final AppException exception;

  SPStateUploadImageFailure({super.isLoading = false, required this.exception});
}

/// Image Uploaded Success
class SPStateUploadedImage extends SPState {}
