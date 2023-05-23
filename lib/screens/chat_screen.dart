import 'package:flutter/material.dart';
import 'package:my_app/services/messages_services.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/custom_icon_avatar.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Employee> empleado =
        ModalRoute.of(context)!.settings.arguments as List<Employee>;
    Employee receiver = empleado[0];
    Employee sender = empleado[1];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ChatTopAppBar(sender: sender),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final conversation = snapshot.data;
            return Text("grande llorente");
          } else if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.black),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primary,
              ),
            );
          }
        },
        future: Provider.of<MessagesService>(context)
            .getConversation(sender, receiver),
      ),
    );
  }
}

class ChatTopAppBar extends StatelessWidget {
  const ChatTopAppBar({
    super.key,
    required this.sender,
  });

  final Employee sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.centerLeft,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        CircularIconAvatar(
          name: sender.name,
          radius: 20,
          fontSize: 15,
          backgroundColor: Colors.white,
          textColor: AppTheme.primary,
        ),
        const SizedBox(width: 10),
        Text(sender.name),
      ],
    );
  }
}
