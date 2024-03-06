abstract class RentalProductEvent {}

// RentalEventInitialize  ========================================
class RentalEventUninitialize extends RentalProductEvent {}

class RentalProductEventInitialize extends RentalProductEvent {}

/// Fetch Products Event
class RentalEventFetchProducts extends RentalProductEvent {}

/// Fetch Single Product Event
class RentalEventFetchProduct extends RentalProductEvent {
  final String productId;

  RentalEventFetchProduct({required this.productId});
}
