// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

// ignore: must_be_immutable
class CustomBottomField extends StatefulWidget {
  CustomBottomField({
    super.key,
    required this.myFormKey,
    required this.formValues,
    required this.message,
    required this.chatProvider,
    required this.sender,
    required this.receiver,
    required this.mensajes,
    required this.setValue,
  });

  final GlobalKey<FormState> myFormKey;
  final Map<String, String> formValues;
  final TextEditingController message;
  final ChatProvider chatProvider;
  final Employee sender;
  final Employee receiver;
  List<Message> mensajes;
  final Function setValue;

  @override
  State<CustomBottomField> createState() => _CustomBoottomFieldState();
}

class _CustomBoottomFieldState extends State<CustomBottomField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppTheme.primary),
      child: SafeArea(
        child: Form(
          key: widget.myFormKey,
          child: CustomInputField(
            formProperty: 'content',
            formValues: widget.formValues,
            controller: widget.message,
            labelText: "Nuevo Mensaje",
            suffixIcon: Icons.send,
            onPressed: () {
              if (widget.message.text.isNotEmpty) {
                widget.chatProvider
                    .sendMessage(
                  widget.sender.dni,
                  widget.receiver.dni,
                  widget.message.text,
                )
                    .listen(
                  (value) {
                    widget.message.clear();
                    widget.chatProvider.mensajes.listen((event) {
                      widget.setValue(event);
                    });
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
