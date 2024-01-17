abstract class RentalState {
  final bool isLoading;
  final String loadingText;
  RentalState({required this.isLoading, this.loadingText = ""});
}

// RentalStateIntialize ========================================
class RentalStateUnInitialize extends RentalState {
  RentalStateUnInitialize({required super.isLoading});
}

class RentalStateInitialize extends RentalState {
  RentalStateInitialize({required super.isLoading});
}
