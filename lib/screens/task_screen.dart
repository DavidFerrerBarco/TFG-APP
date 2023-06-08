import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context)!.settings.arguments as List;
    Employee empleado = data[0] as Employee;
    Task tarea = data[1] as Task;
    return Scaffold(
      appBar: AppBar(title: const Text('Tarea')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
          child: Column(
            children: [
              const Text(
                "TÍTULO",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tarea.title,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "FECHA",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                tarea.date.substring(0, 10),
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                "DESCRIPCIÓN",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tarea.content,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              TaskButtons(
                tarea: tarea,
                empleado: empleado,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
