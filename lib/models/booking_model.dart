// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String rentalUserId;
  final DateTime bookingDate;
  final DateTime createdAt;
  final DateTime? updatedDate;
  final BookingStatus status;
  final DateTime? cancelationDate;

  final String car;
  BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceProviderId,
    required this.rentalUserId,
    required this.bookingDate,
    required this.createdAt,
    required this.status,
    required this.car,
    this.updatedDate,
    this.cancelationDate,
  });

  BookingModel copyWith({
    String? id,
    String? serviceId,
    String? serviceProviderId,
    String? bookingUserName,
    String? bookingUserProfile,
    String? rentalUserId,
    DateTime? bookingDate,
    DateTime? createdAt,
    List<DateTime>? bookingTime,
    BookingStatus? status,
    String? car,
    DateTime? updatedDate,
    DateTime? cancelationDate,
  }) {
    return BookingModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      rentalUserId: rentalUserId ?? this.rentalUserId,
      bookingDate: bookingDate ?? this.bookingDate,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      car: car ?? this.car,
      updatedDate: updatedDate ?? this.updatedDate,
      cancelationDate: cancelationDate ?? this.cancelationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceId': serviceId,
      'serviceProviderId': serviceProviderId,
      'rentalUserId': rentalUserId,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name.toLowerCase(),
      'car': car,
      "updatedDate":
          updatedDate != null ? Timestamp.fromDate(updatedDate!) : null,
      "cancelationDate":
          cancelationDate != null ? Timestamp.fromDate(cancelationDate!) : null,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      serviceProviderId: map['serviceProviderId'] as String,
      rentalUserId: map['rentalUserId'] as String,
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedDate: (map['updatedDate'] as Timestamp?)?.toDate(),
      cancelationDate: (map['cancelationDate'] as Timestamp?)?.toDate(),
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
    return 'BookingModel(id: $id, serviceId: $serviceId, serviceProviderId: $serviceProviderId, rentalUserId: $rentalUserId, bookingDate: $bookingDate, createdAt: $createdAt, status: $status, car: $car, updatedDate: $updatedDate, cancelationDate: $cancelationDate)';
  }

  @override
  bool operator ==(covariant BookingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serviceId == serviceId &&
        other.serviceProviderId == serviceProviderId &&
        other.rentalUserId == rentalUserId &&
        other.bookingDate == bookingDate &&
        other.createdAt == createdAt &&
        other.status == status &&
        other.car == car &&
        other.cancelationDate == cancelationDate &&
        other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceId.hashCode ^
        serviceProviderId.hashCode ^
        rentalUserId.hashCode ^
        bookingDate.hashCode ^
        createdAt.hashCode ^
        status.hashCode ^
        cancelationDate.hashCode ^
        car.hashCode;
  }
}

enum BookingStatus {
  pending("Pending", 0xFF0000FF),
  accepted("Accepted", 0xFFD68910),
  rejected("Rejected", 0xFFFF0000),
  paid("Paid", 0xFF008000);

  const BookingStatus(this.text, this.colorCode);
  final String text;
  final int colorCode;
}
