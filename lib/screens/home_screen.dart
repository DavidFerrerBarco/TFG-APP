import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/providers/providers.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Schedule horario = defaultschedule;
    List<Task> tareas = defaulttasks;
    Size size = MediaQuery.of(context).size;
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'news'),
            icon: const Icon(Icons.newspaper_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'notifications',
                arguments: empleado),
            icon: const Icon(Icons.inbox_rounded),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, 'messages', arguments: empleado),
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: homeProvider.getListaHorarios(empleado),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            homeProvider.horariosDelDia.listen((data) {
              horario = data;
            });
            return StreamBuilder(
              stream: homeProvider.getListaTareas(empleado),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        HomeUserTag(
                          size: size,
                          empleado: empleado,
                        ),
                        HomeCalendar(
                          size: size,
                          inicialDate: DateTime.now(),
                          homeProvider: homeProvider,
                        ),
                        HomeScheduleTag(
                          hora: horario.hours,
                        ),
                        Container(
                          width: 300,
                          height: 250,
                          decoration: const BoxDecoration(
                            color: Color(0xFF008B76),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: StreamBuilder(
                            stream: homeProvider.tareasDelDia,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                tareas = snapshot.data!;
                                return tareas.isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: tareas.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: const Icon(Icons.book,
                                                size: 30),
                                            title: Text(
                                                'Título: ${tareas[index].title}'),
                                            trailing: IconButton(
                                              onPressed: () =>
                                                  Navigator.pushNamed(
                                                      context, 'task'),
                                              icon: const Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                            ),
                                            iconColor: Colors.white,
                                            subtitle: Text(
                                              'Estado: ${tareas[index].status}',
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          );
                                        },
                                      )
                                    : StreamBuilder(
                                        stream: homeProvider.diaSeleccionado,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: Text(
                                                  "No hay tareas asignadas para el ${snapshot.data!.toLocal().toString().substring(0, 10)}",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        StreamBuilder(
                          stream: homeProvider.mostrarBotones,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!) {
                                return const HomeButtonLogs();
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return const CustomCircularProgress();
          }
        },
      ),
    );
  }
}
