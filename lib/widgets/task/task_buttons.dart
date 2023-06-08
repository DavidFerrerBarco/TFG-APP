import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class TaskButtons extends StatelessWidget {
  const TaskButtons({
    super.key,
    required this.tarea,
    required this.empleado,
  });

  final Task tarea;
  final Employee empleado;

  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            height: 100,
            minWidth: 100,
            onPressed: () {
              taskProvider.changeStatus(tarea.id, "Finalizado").listen((value) {
                if (value) {
                  Navigator.popAndPushNamed(context, 'home',
                      arguments: empleado);
                }
              });
            },
            color: AppTheme.primary,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'Finalizar',
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
          ),
          MaterialButton(
            height: 100,
            minWidth: 100,
            onPressed: () {
              taskProvider.changeStatus(tarea.id, "Cancelado").listen((value) {
                if (value) {
                  Navigator.popAndPushNamed(context, 'home',
                      arguments: empleado);
                }
              });
            },
            color: AppTheme.redColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'Cancelar',
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
