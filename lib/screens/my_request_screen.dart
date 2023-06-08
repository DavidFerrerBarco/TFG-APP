import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyRequestScreen extends StatelessWidget {
  const MyRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    final RequestProvider requestProvider =
        Provider.of<RequestProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CommonDrawer(empleado: empleado),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mis Solicitudes"),
      ),
      body: StreamBuilder(
        stream: requestProvider.getSolicitudes(empleado),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Request> solicitudes = snapshot.data!;
            if (solicitudes != [defaultrequest]) {
              solicitudes = solicitudes.reversed.toList();
              return SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: solicitudes.length,
                  itemBuilder: (context, index) {
                    return CustomCards(
                      hour: solicitudes[index].date,
                      title: solicitudes[index].title,
                      content: solicitudes[index].content,
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "NO HAY SOLICITUDES",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              );
            }
          } else {
            return const CustomCircularProgress();
          }
        },
      ),
    );
  }
}
