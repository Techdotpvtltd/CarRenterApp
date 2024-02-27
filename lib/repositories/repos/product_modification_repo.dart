// ignore: dangling_library_doc_comments
/// Project: 	   CarRenterApp
/// File:    	   product_modification_repo
/// Path:    	   lib/repositories/repos/product_modification_repo.dart
/// Author:       Ali Akbar
/// Date:        27-02-24 18:52:03 -- Tuesday
/// Description:

import 'dart:io';

import 'package:beasy/exceptions/exception_parsing.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/repositories/validations/data_validations.dart';
import 'package:beasy/web_services/firestore_services.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/constants.dart';
import '../../web_services/storage_services.dart';
import 'user_repo.dart';

class ProductModificationRepo {
  static final ProductModificationRepo _instance =
      ProductModificationRepo._internal();
  ProductModificationRepo._internal();
  factory ProductModificationRepo() => _instance;

  Future<void> create({required ProductModel productModel}) async {
    try {
      await DataValidation.createProduct(productModel: productModel);
      final Map<String, dynamic> mapData = await FirestoreService()
          .saveWithSpecificIdFiled(
              path: FIREBASE_COLLECTION_USER_SERVICES,
              data: productModel.toMap(),
              docIdFiled: "id");
      debugPrint(mapData.toString());
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Upload Images
  Future<String> uploadImages({required String path}) async {
    try {
      final String collectionPath =
          "$FIREBASE_COLLECTION_USER_SERVICES/${UserRepo().user.uid}/${DateTime.now().microsecondsSinceEpoch}";
      return await StorageService()
          .uploadImage(withFile: File(path), collectionPath: collectionPath);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
