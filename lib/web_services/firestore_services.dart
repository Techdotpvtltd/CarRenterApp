import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  late final FirebaseFirestore _firestore;

  FirestoreService() {
    _firestore = FirebaseFirestore.instance;
  }

//  Save & Update Services ====================================

  ///  Save Data without DocumentId ====================================
  Future<Map<String, dynamic>> saveWithoutDocId(
      {required String path, required Map<String, dynamic> data}) async {
    await _firestore.collection(path).doc().set(data);
    return data;
  }

  /// Save Data With DocumentId
  Future<Map<String, dynamic>> saveWithDocId(
      {required String path,
      required String docId,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(path).doc(docId).set(data);
    return data;
  }

  /// Save Data Without DocId and return with docId field
  /// Save Data With DocumentId
  Future<Map<String, dynamic>> saveWithSpecificIdFiled(
      {required String path,
      required String docId,
      required Map<String, dynamic> data,
      required String docIdFiled}) async {
    final doc = _firestore.collection(path).doc();
    data[docIdFiled] = doc.id;

    /// Save Id in specific fieldz
    await doc.set(data);
    return data;
  }

  /// Update Data with document id
  Future<Map<String, dynamic>> updateWithDocId(
      {required String path,
      required String docId,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(path).doc(docId).update(data);
    return data;
  }

//  Fetch Services ====================================
  Future<Map<String, dynamic>?> fetchSingleRecord({
    required String path,
    required String docId,
  }) async {
    final DocumentSnapshot<Map<String, dynamic>> reference =
        await _firestore.collection(path).doc(docId).get();
    return reference.data();
  }
}
