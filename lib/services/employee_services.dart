import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../constants/constants.dart';

class EmployeeService extends ChangeNotifier {
  login(String dni, String password) async {
    var url = Uri.http(baseUrl, '/api/employee/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'DNI': dni,
        'password': password,
      }),
    );

    if (response.statusCode != 200) return defaultemployee;
    final employeeResponse = EmployeeModel.fromJson(response.body);

    return jsonEncode(employeeResponse.data[0]);
  }
}
