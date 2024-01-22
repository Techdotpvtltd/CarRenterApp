abstract class RentalProductState {
  final bool isLoading;
  final String loadingText;
  RentalProductState({required this.isLoading, this.loadingText = ""});
}

// RentalStateIntialize ========================================
class RentalProductStateUnInitialize extends RentalProductState {
  RentalProductStateUnInitialize({required super.isLoading});
}

class RentalProductStateInitialize extends RentalProductState {
  RentalProductStateInitialize({required super.isLoading});
}
