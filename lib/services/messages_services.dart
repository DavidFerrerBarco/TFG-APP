import '../constants/constants.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagesService extends ChangeNotifier {
  Future getConversation(Employee sender, Employee receiver) async {
    var url = Uri.http(
        baseUrl, '/api/message/sender/${sender.id}/receiver/${receiver.id}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final messagesResponse = MessagesModel.fromJson(response.body);

      return messagesResponse.data;
    } else {
      return [];
    }
  }
}
