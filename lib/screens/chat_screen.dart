import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Employee> empleado =
        ModalRoute.of(context)!.settings.arguments as List<Employee>;
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    Employee receiver = empleado[0];
    Employee sender = empleado[1];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ChatTopAppBar(sender: sender),
      ),
      body: StreamBuilder(
        stream: chatProvider.getConversation(sender, receiver),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Message> mensajes = snapshot.data!;
            if (mensajes != [defaultmessage]) {
              return const Text(
                "AAAAAAAAAA",
                style: TextStyle(color: Colors.black),
              );
            } else {
              return const Center(
                child: Text(
                  "NO SE PUDO CARGAR LOS MENSAJES",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              );
            }
          } else {
            return const CustomCircularProgress();
          }
        },
      ),
    );
  }
}
