// ignore: dangling_library_doc_comments
import 'package:beasy/exceptions/exception_parsing.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/web_services/firestore_services.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_repo
/// Path:    	   lib/repositories/repos/booking_repo.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:26:41 -- Thursday
/// Description:

class BookingRepo {
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
}
