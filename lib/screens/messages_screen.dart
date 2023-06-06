import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeesProvider employeesProvider =
        Provider.of<EmployeesProvider>(context);
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: StreamBuilder(
          stream: employeesProvider.getEmpleados(empleado),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<Employee> empleados = snapshot.data!;
              if (empleados != [defaultemployee]) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: empleados.length,
                    separatorBuilder: (context, index) {
                      return empleados[index].id != empleado.id
                          ? const Divider(
                              color: Colors.grey,
                            )
                          : Container();
                    },
                    itemBuilder: (context, index) {
                      return empleados[index].id != empleado.id
                          ? CustomCardMessage(
                              employee: empleados[index],
                              myEmployee: empleado,
                            )
                          : Container();
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "NO HAY MÁS EMPLEADOS",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                );
              }
            } else {
              return const CustomCircularProgress();
            }
          }),
    );
  }
}
