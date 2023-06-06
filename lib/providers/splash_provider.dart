import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/storage.dart';

class SplashProvider extends ChangeNotifier {
  Stream<Employee> get loading async* {
    await Future.delayed(const Duration(seconds: 2));
    final String employee = await SecureStorage().readSecureData('user');
    yield Employee.fromJson(employee);
  }
}
