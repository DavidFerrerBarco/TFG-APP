import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/services/storage.dart';

import '../models/models.dart';
import '../constants/constants.dart';

class EmployeeService extends ChangeNotifier {
  List<Employee> onDisplayEmployees = [];

  EmployeeService() {
    getAllEmployees();
  }

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

  getAllEmployees() async {
    var empleado =
        Employee.fromJson(await SecureStorage().readSecureData('user'));
    String company = empleado.company.replaceAll(' ', '-');
    if (empleado.token != null) {
      var url = Uri.http(baseUrl, '/api/employee/company/$company');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final employeeResponse = EmployeeModel.fromJson(response.body);

        onDisplayEmployees = employeeResponse.data;

        notifyListeners();
      }
    }
  }
}
