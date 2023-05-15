import '../constants/constants.dart';
import '../models/models.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/services/storage.dart';

class ScheduleService extends ChangeNotifier {
  List<Schedule> listaHorario = [];

  ScheduleService() {
    horarios();
  }

  horarios() async {
    var empleado =
        Employee.fromJson(await SecureStorage().readSecureData('user'));
    if (empleado.token != null) {
      var url = Uri.http(baseUrl, '/api/schedule/employee/${empleado.id}');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${empleado.token}',
        },
      );
      final scheduleResponse = ScheduleModel.fromJson(response.body);
      listaHorario = scheduleResponse.data;
    }

    notifyListeners();
  }
}
