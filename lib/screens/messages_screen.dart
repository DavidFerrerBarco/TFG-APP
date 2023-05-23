import 'package:my_app/theme/app_theme.dart';

import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Employee> employees =
        Provider.of<EmployeeService>(context).onDisplayEmployees;
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: employees.length,
          separatorBuilder: (context, index) {
            return employees[index].id != empleado.id
                ? const Divider(
                    color: Colors.grey,
                  )
                : Container();
          },
          itemBuilder: (context, index) {
            return employees[index].id != empleado.id
                ? CustomCardMessage(
                    employee: employees[index], myEmployee: empleado)
                : Container();
          },
        ),
      ),
    );
  }
}
