import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  Stream<List<Message>> getConversation(
    Employee sender,
    Employee receiver,
  ) async* {
    await Future.delayed(const Duration(milliseconds: 200));
    var url = Uri.http(
        baseUrl, '/api/message/sender/${sender.id}/receiver/${receiver.id}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final MessagesModel messagesModel =
            MessagesModel.fromJson(response.body);
        yield messagesModel.data;
      } else {
        <Message>[];
      }
    } catch (error) {
      yield [defaultmessage];
    }
  }
}
