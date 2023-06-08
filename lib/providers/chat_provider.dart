import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  List<Message> _mensajes = <Message>[];

  Stream<List<Message>> get mensajes async* {
    yield _mensajes;
  }

  void setLista(List<Message> nuevaLista) {
    _mensajes = nuevaLista;
  }

  void addMensaje(Message newMensaje) {
    _mensajes.add(newMensaje);
  }

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
        setLista(messagesModel.data);
        yield _mensajes;
      } else {
        <Message>[];
      }
    } catch (error) {
      yield [defaultmessage];
    }
  }

  // -------------------------------------------------------------------------

  Stream<bool> sendMessage(
      String sender, String receiver, String content) async* {
    var url = Uri.http(baseUrl, "/api/message/");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "sender": sender,
          "receiver": receiver,
          "content": content,
        }),
      );
      if (response.statusCode == 201) {
        final MessagesModel messagesModel =
            MessagesModel.fromJson(response.body);
        addMensaje(messagesModel.data[0]);
        yield true;
      } else {
        yield false;
      }
    } catch (error) {
      yield false;
    }
  }
}
