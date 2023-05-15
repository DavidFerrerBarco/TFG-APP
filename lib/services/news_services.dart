import '../constants/constants.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier {
  List<News> onDisplayNews = [];

  NewsService() {
    getAllNews();
  }

  getAllNews() async {
    var url = Uri.http(baseUrl, '/api/news');

    final response = await http.get(url);
    final newsResponse = NewsModel.fromJson(response.body);

    onDisplayNews = newsResponse.data;

    notifyListeners();
  }
}
