import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Project: 	   CarRenterApp
/// File:    	   product_model
/// Path:    	   lib/models/product_model.dart
/// Author:       Ali Akbar
/// Date:        27-02-24 16:37:20 -- Tuesday
/// Description:

class ProductModel {
  final String id;
  final String ownerId;
  final DateTime createdAt;
  final List<String> images;
  final String name;
  final String? description;
  final String model;
  final int year;
  final double price;
  final double latitude;
  final double longitude;
  ProductModel({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.images,
    required this.name,
    this.description,
    required this.model,
    required this.year,
    required this.price,
    required this.latitude,
    required this.longitude,
  });

  ProductModel copyWith({
    String? id,
    String? ownerId,
    DateTime? createdAt,
    List<String>? images,
    String? name,
    String? description,
    String? model,
    int? year,
    double? price,
    double? latitude,
    double? longitude,
  }) {
    return ProductModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      name: name ?? this.name,
      description: description ?? this.description,
      model: model ?? this.model,
      year: year ?? this.year,
      price: price ?? this.price,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'createdAt': Timestamp.fromDate(createdAt),
      'images': images,
      'name': name,
      'description': description,
      'model': model,
      'year': year,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String? ?? "",
      ownerId: map['ownerId'] as String? ?? "",
      createdAt: (map['createdAt'] as Timestamp? ?? Timestamp.now()).toDate(),
      images: (map['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      name: map['name'] as String? ?? "",
      description: map['description'],
      model: map['model'] as String? ?? "",
      year: map['year'] as int? ?? 0,
      price: map['price'] as double? ?? 0.0,
      latitude: map['latitude'] as double? ?? 0,
      longitude: map['longitude'] as double? ?? 0,
    );
  }
  @override
  String toString() {
    return 'ProductModel(id: $id, ownerId: $ownerId, createdAt: $createdAt, images: $images, name: $name, description: $description, model: $model, year: $year, price: $price, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ownerId == ownerId &&
        other.createdAt == createdAt &&
        listEquals(other.images, images) &&
        other.name == name &&
        other.description == description &&
        other.model == model &&
        other.year == year &&
        other.price == price &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ownerId.hashCode ^
        createdAt.hashCode ^
        images.hashCode ^
        name.hashCode ^
        description.hashCode ^
        model.hashCode ^
        year.hashCode ^
        price.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
