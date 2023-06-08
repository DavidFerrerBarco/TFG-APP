import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/constants/constants.dart';

class TaskProvider extends ChangeNotifier {
  Stream<bool> changeStatus(String id, String status) async* {
    var url = Uri.http(baseUrl, '/api/task/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "status": status,
        }),
      );

      yield response.statusCode == 200;
    } catch (error) {
      yield false;
    }
  }
}
