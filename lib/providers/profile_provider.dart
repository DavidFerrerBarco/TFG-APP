import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/providers/providers.dart';

class ProfilerProvider extends ChangeNotifier {
  Stream<Employee> newPassword(Employee empleado, String password) async* {
    var url = Uri.http(baseUrl, 'api/employee/${empleado.id}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        final EmployeeModel employeeModel =
            EmployeeModel.fromJson(response.body);

        await SecureStorage()
            .writeSecureData('user', jsonEncode(employeeModel.data[0]));

        yield employeeModel.data[0];
      } else {
        yield defaultemployee;
      }
    } catch (error) {
      yield defaultemployee;
    }
  }
}
