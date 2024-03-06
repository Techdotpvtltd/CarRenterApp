// ignore: dangling_library_doc_comments
/// Project: 	   CarRenterApp
/// File:    	   mutuble_product_repo
/// Path:    	   lib/repositories/repos/mutuble_product_repo.dart
/// Author:       Ali Akbar
/// Date:        27-02-24 18:52:03 -- Tuesday
/// Description:

import 'dart:io';

import 'package:beasy/exceptions/exception_parsing.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/repositories/validations/data_validations.dart';
import 'package:beasy/web_services/firestore_services.dart';

import '../../utilities/constants/constants.dart';
import '../../web_services/storage_services.dart';
import 'user_repo.dart';

class MutableProductRepo {
  Future<void> create({required ProductModel productModel}) async {
    try {
      await DataValidation.product(productModel: productModel);
      final Map<String, dynamic> mapData = await FirestoreService()
          .saveWithSpecificIdFiled(
              path: FIREBASE_COLLECTION_USER_SERVICES,
              data: productModel.toMap(),
              docIdFiled: "id");
      final ProductModel product = ProductModel.fromMap(mapData);
      ImmutableProductRepo().addProduct = product;
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

// Update Product

  Future<void> update({required ProductModel productModel}) async {
    try {
      await DataValidation.product(productModel: productModel);
      final Map<String, dynamic> mapData = await FirestoreService()
          .updateWithDocId(
              path: FIREBASE_COLLECTION_USER_SERVICES,
              docId: productModel.id,
              data: productModel.toMap());
      final ProductModel updatedData = ProductModel.fromMap(mapData);
      ImmutableProductRepo().updateProduct(updatedData);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Upload Images
  Future<String> uploadImages({required String path}) async {
    try {
      final String collectionPath =
          "$FIREBASE_COLLECTION_USER_SERVICES/${UserRepo().currentUser.uid}/${DateTime.now().microsecondsSinceEpoch}";
      return await StorageService()
          .uploadImage(withFile: File(path), collectionPath: collectionPath);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Delete Product
  Future<void> deleteProduct({required int index}) async {
    try {
      final String productId = ImmutableProductRepo().products[index].id;
      FirestoreService().delete(
          collection: FIREBASE_COLLECTION_USER_SERVICES, docId: productId);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
