import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  Box box;
  HiveStorage(this.box);

  Future<void> put(dynamic key, dynamic value) async {
    return await box.put(key, value);
  }

  dynamic get(String key) {
    return box.get(key);
  }

  dynamic getAt(int key) {
    return box.getAt(key);
  }

  Future<int> add(value) async {
    return await box.add(value);
  }

  Future<int> clear() async {
    return await box.clear();
  }

  Future<void> delete(value) async {
    return await box.delete(value);
  }

  Future<void> putAll(Map<String, dynamic> entries) async {
    return await box.putAll(entries);
  }
}
