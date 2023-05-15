import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CardsNN extends StatefulWidget {
  final String title;
  final String hour;
  final String content;

  const CardsNN({
    super.key,
    required this.title,
    required this.hour,
    required this.content,
  });

  @override
  State<CardsNN> createState() => _CardsNNState();
}

class _CardsNNState extends State<CardsNN> {
  bool mostrarTodo = false;

  void cambiarValor() {
    setState(() {
      mostrarTodo = !mostrarTodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppTheme.primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.hour,
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
            Text(
              widget.title,
              style: AppTheme.lightTheme.textTheme.labelLarge,
              textAlign: TextAlign.justify,
            ),
            const Divider(
              color: AppTheme.secondary,
              height: 20,
            )
          ],
        ),
        subtitle: Column(
          children: [
            Text(
              widget.content,
              textAlign: TextAlign.justify,
              maxLines: mostrarTodo ? 200 : 3,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.lightTheme.textTheme.labelMedium,
            ),
            Center(
              child: IconButton(
                onPressed: () => cambiarValor(),
                icon: mostrarTodo
                    ? const Icon(Icons.keyboard_arrow_up_outlined)
                    : const Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ),
          ],
        ),
        textColor: Colors.black,
        onTap: () => cambiarValor(),
      ),
    );
  }
}
