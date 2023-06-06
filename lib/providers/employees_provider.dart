import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class EmployeesProvider extends ChangeNotifier {
  Stream<List<Employee>> getEmpleados(Employee employee) async* {
    String validCompany = employee.company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, '/api/employee/company/$validCompany');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final EmployeeModel employeeModel =
            EmployeeModel.fromJson(response.body);
        yield employeeModel.data;
      } else {
        <Employee>[];
      }
    } catch (error) {
      yield [defaultemployee];
    }
  }
}
