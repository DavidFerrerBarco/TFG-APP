import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

class NewProvider extends ChangeNotifier {
  Stream<List<News>> get getNoticias async* {
    await Future.delayed(const Duration(milliseconds: 500));
    var url = Uri.http(baseUrl, '/api/news');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final newsResponse = NewsModel.fromJson(response.body);
        yield newsResponse.data;
      } else {
        yield <News>[];
      }
    } catch (error) {
      yield [defaultnews];
    }
  }
}
