// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:beasy/utilities/extensions/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final UserLocation location;
  final UserType? userType;
  final String? imageUrl;
  final int? countryCode;
  final String? phoneNumber;
  final DateTime createAt;
  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.location,
    this.userType,
    this.imageUrl,
    this.countryCode,
    required this.createAt,
    this.phoneNumber,
  });

  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    UserLocation? location,
    UserType? userType,
    String? imageUrl,
    int? countryCode,
    String? phoneNumber,
    DateTime? createAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      location: location ?? this.location,
      userType: userType ?? this.userType,
      imageUrl: imageUrl ?? this.imageUrl,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'location': location.toMap(),
      'imageUrl': imageUrl,
      // 'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'createdAt': Timestamp.fromDate(createAt),
    };
  }

  static Future<UserModel> fromMap(Map<String, dynamic> map) async {
    return UserModel(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String? ?? "",
      lastName: map['lastName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      location: UserLocation.fromMap(
          map['location'] as Map<String, dynamic>? ?? <String, dynamic>{}),
      userType: await LocalPreferences.getUserType(),
      imageUrl: map['imageUrl'] as String?,
      // countryCode: map['countryCode'] as int?,
      phoneNumber: map['phoneNumber'] as String?,
      createAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, location: $location, userType: $userType, imageUrl: $imageUrl, countryCode: $countryCode, phoneNumber: $phoneNumber, createdAt: ${createAt.toString()})';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.location == location &&
        other.userType == userType &&
        other.imageUrl == imageUrl &&
        other.countryCode == countryCode &&
        other.createAt.millisecond == createAt.millisecond &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        location.hashCode ^
        userType.hashCode ^
        imageUrl.hashCode ^
        countryCode.hashCode ^
        phoneNumber.hashCode;
  }
}

class UserLocation {
  final double latitude;
  final double longitude;
  final String? country;
  final String? city;
  final String? streat;
  final String? address;
  UserLocation({
    required this.latitude,
    required this.longitude,
    this.country,
    this.city,
    this.streat,
    this.address,
  });

  UserLocation copyWith({
    double? attitude,
    double? lattitude,
    String? country,
    String? city,
    String? streat,
    String? address,
  }) {
    return UserLocation(
      latitude: attitude ?? latitude,
      longitude: lattitude ?? longitude,
      country: country ?? this.country,
      city: city ?? this.city,
      streat: streat ?? this.streat,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'city': city,
      'streat': streat,
      'address': address,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      latitude: map['latitude'] as double? ?? 0,
      longitude: map['longitude'] as double? ?? 0,
      country: map['country'] as String? ?? "",
      city: map['city'] as String?,
      streat: map['streat'] as String?,
      address: map['address'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLocation(attitude: $latitude, lattitude: $longitude, country: $country, city: $city, streat: $streat, address: $address)';
  }

  @override
  bool operator ==(covariant UserLocation other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.country == country &&
        other.city == city &&
        other.streat == streat &&
        other.address == address;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        country.hashCode ^
        city.hashCode ^
        streat.hashCode ^
        address.hashCode;
  }
}

enum UserType {
  rentalUser,
  serviceProvider,
}
