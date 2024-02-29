// ignore: dangling_library_doc_comments
/// Project: 	   CarRenterApp
/// File:    	   immutable_product_repo
/// Path:    	   lib/repositories/repos/immutable_product_repo.dart
/// Author:       Ali Akbar
/// Date:        28-02-24 12:40:28 -- Wednesday
/// Description:

import 'package:beasy/exceptions/exception_parsing.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/web_services/firestore_services.dart';
import 'package:flutter/material.dart';

class ImmutableProductRepo {
  // ==========================Singleton Instance=================================
  static final ImmutableProductRepo _instance =
      ImmutableProductRepo._internal();
  ImmutableProductRepo._internal();
  factory ImmutableProductRepo() => _instance;
  // ===========================Properties================================
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  set addProduct(ProductModel productModel) =>
      _products.insert(0, productModel);

  void updateProduct(ProductModel updatedData) {
    final int index =
        _products.indexWhere((element) => element.id == updatedData.id);
    if (index != -1) {
      _products[index] = updatedData;
    }
  }

  void delete(int atIndex) {
    _products.removeAt(atIndex);
  }

  /// Check the user type
  final UserType? type = UserRepo().currentUser.userType;

  // ===========================Methods================================

  /// Fetch All The Products
  Future<void> fetchProducts() async {
    try {
      /// For Service Provider
      if (type == UserType.serviceProvider) {
        final String userId = UserRepo().currentUser.uid;
        final List<Map<String, dynamic>> data = await FirestoreService()
            .fetchWithEqual(
                collection: FIREBASE_COLLECTION_USER_SERVICES,
                filedId: "ownerId",
                isEqualTo: userId);
        _products = data.map((e) => ProductModel.fromMap(e)).toList();
        debugPrint(_products.length.toString());
      }

      /// For rental user
      if (type == UserType.rentalUser) {
        final List<Map<String, dynamic>> data = await FirestoreService()
            .fetchRecords(collection: FIREBASE_COLLECTION_USER_SERVICES);
        _products = data.map((e) => ProductModel.fromMap(e)).toList();
      }
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
