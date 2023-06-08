import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/theme/app_theme.dart';

class CustomChatMessage extends StatefulWidget {
  final List<Message> mensajes;
  final Employee sender;
  final Employee receiver;
  const CustomChatMessage({
    super.key,
    required this.mensajes,
    required this.sender,
    required this.receiver,
  });

  @override
  State<CustomChatMessage> createState() => _CustomChatMessageState();
}

class _CustomChatMessageState extends State<CustomChatMessage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: widget.mensajes.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment:
              widget.mensajes[index].sender.toString() == widget.sender.dni
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            if (widget.mensajes[index].sender.toString() != widget.sender.dni)
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 3.0,
                ),
                child: Text(
                  widget.mensajes[index].date.toString().substring(11, 16),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.66),
              decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(
                    widget.mensajes[index].sender.toString() ==
                            widget.sender.dni
                        ? 1
                        : 0.1,
                  ),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                widget.mensajes[index].content,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.mensajes[index].sender.toString() ==
                          widget.sender.dni
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            if (widget.mensajes[index].sender.toString() == widget.sender.dni)
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 3.0,
                ),
                child: Text(
                  widget.mensajes[index].date.toString().substring(11, 16),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
