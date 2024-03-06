import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/product_model.dart';

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

// ===========================Create Product States ================================
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

// =========================== Update Product States ================================
/// Updating Service State
class SPStateUpdatingProduct extends SPState {
  SPStateUpdatingProduct(
      {super.isLoading = true, super.loadingText = "Creating Product."});
}

/// UpdateProductFailure
class SPStateUpdateProductFailure extends SPState {
  final AppException exception;

  SPStateUpdateProductFailure(
      {super.isLoading = false, required this.exception});
}

/// updateProductSuccess
class SPStateUpdatedProduct extends SPState {}

// ===========================Upload Images================================

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

// =========================== Fetch Products States ================================

/// Fetching Products
class SPStateFetchingProducts extends SPState {
  SPStateFetchingProducts(
      {super.isLoading = true, super.loadingText = "Fetching..."});
}

/// Fetch Products Failure
class SPStateFetchProductsFailure extends SPState {
  final AppException exception;

  SPStateFetchProductsFailure({required this.exception});
}

/// Fetched Products
class SPStateProductsFetched extends SPState {
  final List<ProductModel> products;

  SPStateProductsFetched({required this.products});
}

// ===========================Delete Service State================================
class SPStateProductDeleted extends SPState {}
