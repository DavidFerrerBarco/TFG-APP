import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> mensajes = [];

  void setValue(List<Message> newList) {
    setState(() {
      mensajes = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Employee> empleado =
        ModalRoute.of(context)!.settings.arguments as List<Employee>;
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    Employee sender = empleado[0];
    Employee receiver = empleado[1];
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'content': '',
    };
    var message = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ChatTopAppBar(receiver: receiver),
      ),
      body: StreamBuilder(
        stream: chatProvider.getConversation(sender, receiver),
        builder: (context, snapshot) {
          mensajes = snapshot.data ?? [];
          mensajes = mensajes.reversed.toList();
          if (mensajes != [defaultmessage]) {
            return Column(
              children: [
                Expanded(
                  child: CustomChatMessage(
                    mensajes: mensajes,
                    sender: sender,
                    receiver: receiver,
                  ),
                ),
                CustomBottomField(
                  myFormKey: myFormKey,
                  formValues: formValues,
                  message: message,
                  chatProvider: chatProvider,
                  sender: sender,
                  receiver: receiver,
                  mensajes: mensajes,
                  setValue: setValue,
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "NO SE PUDO CARGAR LOS MENSAJES",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
