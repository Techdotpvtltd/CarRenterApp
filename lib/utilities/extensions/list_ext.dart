import 'package:flutter/material.dart';

extension ListEx on List {
  void update<T>(T data, T replaceData) {
    int index = indexOf(data);
    debugPrint(index.toString());
    if (index != -1) {
      this[index] = replaceData;
    }
  }
}
