import 'dart:convert';

class Message {
  String id;
  String sender;
  String receiver;
  String content;
  String date;
  int v;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.date,
    required this.v,
  });

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sender: json["sender"],
        receiver: json["receiver"],
        content: json["content"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "receiver": receiver,
        "content": content,
        "date": date,
        "__v": v,
      };
}
