import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/constants/constants.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeDate = await _storage.write(key: key, value: value);
    return writeDate;
  }

  Future readSecureData(String key) async {
    var readData = await _storage.read(key: key) ?? jsonEncode(defaultemployee);
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
