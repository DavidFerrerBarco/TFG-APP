import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

class RequestProvider extends ChangeNotifier {
  Stream<List<Request>> getSolicitudes(Employee empleado) async* {
    await Future.delayed(const Duration(milliseconds: 500));
    var url = Uri.http(baseUrl, '/api/request/employee/${empleado.dni}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final RequestModel requestModel = RequestModel.fromJson(response.body);
        yield requestModel.data;
      } else {
        yield <Request>[];
      }
    } catch (error) {
      yield [defaultrequest];
    }
  }

  // -----------------------------------------------------

  Stream<bool> sendRequest(
    Employee empleado,
    String title,
    String content,
  ) async* {
    var url = Uri.http(baseUrl, '/api/request');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "employee": empleado.dni,
          "title": title,
          "content": content,
        }),
      );
      yield response.statusCode == 201;
    } catch (error) {
      yield false;
    }
  }
}
