import '../constants/constants.dart';
import '../models/models.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/services/storage.dart';

class TaskService extends ChangeNotifier {
  List<Task> listaTarea = [];

  TaskService(){
    tareas();
  }

  tareas() async {
    var empleado = Employee.fromJson(await SecureStorage().readSecureData('user'));
    if(empleado.token != null){
      var url = Uri.http(baseUrl, '/api/task/employee/${empleado.id}');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${empleado.token}',
        },
      );
      final taskResponse = TaskModel.fromJson(response.body);
      listaTarea = taskResponse.data;
    }

    notifyListeners();
  }
}