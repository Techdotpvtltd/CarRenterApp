// ignore: dangling_library_doc_comments
import '../../exceptions/exception_parsing.dart';
import '../../models/booking_model.dart';
import '../../utilities/constants/constants.dart';
import '../../web_services/firestore_services.dart';

/// Project: 	   CarRenterApp
/// File:    	   mutable_booking_repo
/// Path:    	   lib/repositories/repos/mutable_booking_repo.dart
/// Author:       Ali Akbar
/// Date:        05-03-24 17:10:43 -- Tuesday
/// Description:

class MutableBookingRepo {
  /// Create Booking
  Future<void> create({required BookingModel model}) async {
    try {
      await FirestoreService().saveWithSpecificIdFiled(
          path: FIREBASE_COLLECTION_BOOKING,
          data: model.toMap(),
          docIdFiled: "id");
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  /// Create Booking
  Future<BookingModel> update({required BookingModel model}) async {
    try {
      final updatedData = await FirestoreService().updateWithDocId(
          path: FIREBASE_COLLECTION_BOOKING,
          docId: model.id,
          data: model.toMap());
      return BookingModel.fromMap(updatedData);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }

  Future<void> updateData(
      {required Map<String, dynamic> data, required String id}) async {
    try {
      await FirestoreService().updateDataWithDocId(
          path: FIREBASE_COLLECTION_BOOKING, docId: id, data: data);
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
