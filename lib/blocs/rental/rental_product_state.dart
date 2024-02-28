import '../../exceptions/app_exceptions.dart';
import '../../models/product_model.dart';

abstract class RentalProductState {
  final bool isLoading;
  final String loadingText;
  RentalProductState({this.isLoading = false, this.loadingText = ""});
}

// RentalStateIntialize ========================================
class RentalProductStateUnInitialize extends RentalProductState {
  RentalProductStateUnInitialize({required super.isLoading});
}

class RentalProductStateInitialize extends RentalProductState {
  RentalProductStateInitialize({required super.isLoading});
}

// =========================== Fetch Products States ================================

/// Fetching Products
class RentalStateFetchingProducts extends RentalProductState {
  RentalStateFetchingProducts(
      {super.isLoading = true, super.loadingText = "Fetching..."});
}

/// Fetch Products Failure
class RentalStateFetchProductsFailure extends RentalProductState {
  final AppException exception;

  RentalStateFetchProductsFailure({required this.exception});
}

/// Fetched Products
class RentalStateProductsFetched extends RentalProductState {
  final List<ProductModel> products;

  RentalStateProductsFetched({required this.products});
}
