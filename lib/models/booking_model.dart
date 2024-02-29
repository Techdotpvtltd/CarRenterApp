// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// ignore: dangling_library_doc_comments
/// Project: 	   CarRenterApp
/// File:    	   booking_model
/// Path:    	   lib/models/booking_model.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 14:03:22 -- Thursday
/// Description:

class BookingModel {
  final String id;
  final String serviceId;
  final String serviceProviderId;
  final String bookingUserName;
  final String bookingUserProfile;
  final String bookingUserId;
  final DateTime bookingDate;
  final DateTime createdAt;
  final List<DateTime> bookingTime;
  final BookingStatus status;
  final String car;
  BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceProviderId,
    required this.bookingUserName,
    required this.bookingUserProfile,
    required this.bookingUserId,
    required this.bookingDate,
    required this.createdAt,
    required this.bookingTime,
    required this.status,
    required this.car,
  });

  BookingModel copyWith({
    String? id,
    String? serviceId,
    String? serviceProviderId,
    String? bookingUserName,
    String? bookingUserProfile,
    String? bookingUserId,
    DateTime? bookingDate,
    DateTime? createdAt,
    List<DateTime>? bookingTime,
    BookingStatus? status,
    String? car,
  }) {
    return BookingModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      bookingUserName: bookingUserName ?? this.bookingUserName,
      bookingUserProfile: bookingUserProfile ?? this.bookingUserProfile,
      bookingUserId: bookingUserId ?? this.bookingUserId,
      bookingDate: bookingDate ?? this.bookingDate,
      createdAt: createdAt ?? this.createdAt,
      bookingTime: bookingTime ?? this.bookingTime,
      status: status ?? this.status,
      car: car ?? this.car,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceId': serviceId,
      'serviceProviderId': serviceProviderId,
      'bookingUserName': bookingUserName,
      'bookingUserProfile': bookingUserProfile,
      'bookingUserId': bookingUserId,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'bookingTime': bookingTime.map((x) => Timestamp.fromDate(x)).toList(),
      'status': status.name.toLowerCase(),
      'car': car,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      bookingUserName: map['bookingUserName'] as String,
      bookingUserProfile: map['bookingUserProfile'] as String,
      bookingUserId: map['bookingUserId'] as String,
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      bookingTime: List<DateTime>.from(
        (map['bookingTime'] as List<Timestamp>).map<DateTime>(
          (x) => x.toDate(),
        ),
      ),
      status: BookingStatus.values
          .firstWhere((e) => e.name.toLowerCase() == map['status']),
      car: map['car'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingModel(id: $id, serviceId: $serviceId, serviceProviderId: $serviceProviderId, bookingUserName: $bookingUserName, bookingUserProfile: $bookingUserProfile, bookingUserId: $bookingUserId, bookingDate: $bookingDate, createdAt: $createdAt, bookingTime: $bookingTime, status: $status, car: $car)';
  }

  @override
  bool operator ==(covariant BookingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serviceId == serviceId &&
        other.serviceProviderId == serviceProviderId &&
        other.bookingUserName == bookingUserName &&
        other.bookingUserProfile == bookingUserProfile &&
        other.bookingUserId == bookingUserId &&
        other.bookingDate == bookingDate &&
        other.createdAt == createdAt &&
        listEquals(other.bookingTime, bookingTime) &&
        other.status == status &&
        other.car == car;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceId.hashCode ^
        serviceProviderId.hashCode ^
        bookingUserName.hashCode ^
        bookingUserProfile.hashCode ^
        bookingUserId.hashCode ^
        bookingDate.hashCode ^
        createdAt.hashCode ^
        bookingTime.hashCode ^
        status.hashCode ^
        car.hashCode;
  }
}

enum BookingStatus { pending, accepted, rejected, paid }
