// ignore: dangling_library_doc_comments
import 'package:beasy/repositories/repos/user_repo.dart';

import '../../exceptions/exception_parsing.dart';
import '../../models/booking_model.dart';
import '../../models/query_model.dart';
import '../../models/user_model.dart';
import '../../utilities/constants/constants.dart';
import '../../web_services/firestore_services.dart';

/// Project: 	   CarRenterApp
/// File:    	   notification_repo
/// Path:    	   lib/repositories/repos/notification_repo.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 19:06:37 -- Thursday
/// Description:

class NotificationRepo {
  // ===========================Singleton Instance================================
  static final NotificationRepo _instance = NotificationRepo._internal();
  NotificationRepo._internal();
  factory NotificationRepo() => _instance;

  // =========================== Properties ================================
  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;

  /// Fetching Bookings
  Future<void> fetchForServiceProvider() async {
    try {
      final UserModel user = UserRepo().currentUser;
      final List<Map<String, dynamic>> data =
          await FirestoreService().fetchWithMultipleConditions(
        collection: FIREBASE_COLLECTION_BOOKING,
        queries: [
          QueryModel(
              field: "serviceProviderId",
              value: user.uid,
              type: QueryType.isEqual),
          QueryModel(
            field: "createdAt",
            value: true,
            type: QueryType.orderBy,
          ),
        ],
      );
      _bookings = data.map((e) => BookingModel.fromMap(e)).toList();
    } catch (e) {
      throw thrownAppException(e: e);
    }
  }
}
