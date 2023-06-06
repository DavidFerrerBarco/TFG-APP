import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/storage.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool> login(String dni, String password) async {
    var url = Uri.http(baseUrl, 'api/employee/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "DNI": dni,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        final EmployeeModel employeeModel =
            EmployeeModel.fromJson(response.body);

        SecureStorage()
            .writeSecureData('user', jsonEncode(employeeModel.data[0]));

        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
