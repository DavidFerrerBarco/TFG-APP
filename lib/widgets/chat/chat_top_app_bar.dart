import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

class ChatTopAppBar extends StatelessWidget {
  const ChatTopAppBar({
    super.key,
    required this.receiver,
  });

  final Employee receiver;

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
          name: receiver.name,
          radius: 20,
          fontSize: 15,
          backgroundColor: Colors.white,
          textColor: AppTheme.primary,
        ),
        const SizedBox(width: 10),
        Text(receiver.name),
      ],
    );
  }
}
