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

  /// Mutliple records fetching method

  Future<List<Map<String, dynamic>>> fetchRecords({
    required String collection,
  }) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collection).get();
    return snapshot.docs
        .map((e) => e.data() as Map<String, dynamic>? ?? <String, dynamic>{})
        .toList();
  }

  /// Mutliple records fetching query method
  Future<List<Map<String, dynamic>>> _getWithQuery(
      {required Query<Map<String, dynamic>> query}) async {
    final snapshot = await query.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  /// With Equal Condition
  Future<List<Map<String, dynamic>>> fetchWithEqual({
    required String collection,
    required String filedId,
    required dynamic isEqualTo,
  }) async {
    final Query<Map<String, dynamic>> query =
        _firestore.collection(collection).where(filedId, isEqualTo: isEqualTo);
    return _getWithQuery(query: query);
  }

  //  Delete Services ====================================
  Future<void> delete(
      {required String collection, required String docId}) async {
    final ref = _firestore.collection(collection).doc(docId);
    await ref.delete();
  }
}
