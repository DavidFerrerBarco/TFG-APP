import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

import '../models/models.dart';

class CustomCardMessage extends StatelessWidget {
  const CustomCardMessage({
    super.key,
    required this.employee,
    required this.myEmployee,
  });

  final Employee employee;
  final Employee myEmployee;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        employee.name,
        style: const TextStyle(fontSize: 18),
      ),
      textColor: Colors.black,
      leading: CircularIconAvatar(
        name: employee.name,
        radius: 20,
        fontSize: 18,
        backgroundColor: AppTheme.primary,
        textColor: Colors.white,
      ),
      onTap: () => Navigator.pushNamed(context, 'chat', arguments: [
        myEmployee,
        employee,
      ]),
    );
  }
}
