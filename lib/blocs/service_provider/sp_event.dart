import 'package:beasy/models/product_model.dart';

abstract class SPEvent {}

class SPEventInitialize extends SPEvent {}

class SPEventUninitialize extends SPEvent {}

class SPEventCreateProduct extends SPEvent {
  final ProductModel model;

  SPEventCreateProduct({required this.model});
}
