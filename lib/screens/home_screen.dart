import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/services/storage.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool mostrarBotones = true;
  DateTime day = DateTime.now();
  Schedule horario = defaultschedule;
  List<Task> tareas = defaulttask;

  List<Schedule> obtenerListaHHoy(List<Schedule> listaHorario) {
    return listaHorario
        .where((element) => element.day == day.toString().substring(0, 10))
        .toList();
  }

  List<Task> obtenerListaTHoy(List<Task> listaTarea) {
    return listaTarea
        .where((element) => element.day == day.toString().substring(0, 10))
        .toList();
  }

  Schedule settearHorarioDia(List<Schedule> lista) {
    return lista.isNotEmpty ? lista.first : defaultschedule;
  }

  List<Task> settearTareasDia(List<Task> tareas) {
    return tareas.isNotEmpty ? tareas : defaulttask;
  }

  void setDate(
      DateTime date, List<Schedule> listaHorario, List<Task> listaTarea) {
    setState(() {
      day = date;
      var listaH = obtenerListaHHoy(listaHorario);
      horario = settearHorarioDia(listaH);
      var listaT = obtenerListaTHoy(listaTarea);
      tareas = settearTareasDia(listaT);
      mostrarBotones = date.day == DateTime.now().day;
    });
  }

  void setAllData(List<Schedule> listaHorario, List<Task> listaTarea) {
    setState(() {
      var listaH = obtenerListaHHoy(listaHorario);
      horario = settearHorarioDia(listaH);
      var listaT = obtenerListaTHoy(listaTarea);
      tareas = settearTareasDia(listaT);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Employee empleado =
        Employee.fromJson(ModalRoute.of(context)!.settings.arguments as String);
    final listaHorario = Provider.of<ScheduleService>(context).listaHorario;
    final listaTarea = Provider.of<TaskService>(context).listaTarea;
    setAllData(listaHorario, listaTarea);
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
            onPressed: () => Navigator.pushNamed(context, 'notifications'),
            icon: const Icon(Icons.inbox_rounded),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, 'messages', arguments: empleado),
            icon: const Icon(Icons.chat),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(children: [
          Stack(
            children: [
              TopTag(size: size, empleado: empleado),
            ],
          ),
          Calendar(
            size: size,
            inicialDate: day,
            setDate: setDate,
            day: day,
            listaHorarios: listaHorario,
            listaTareas: listaTarea,
          ),
          ScheduleTag(hora: horario.hours),
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
            child: tareas.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tareas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.book, size: 30),
                        title: Text('Título: ${tareas[index].title}'),
                        trailing: IconButton(
                          onPressed: () => Navigator.pushNamed(context, 'task'),
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        iconColor: Colors.white,
                        subtitle: Text(
                          'Estado: ${tareas[index].status}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "No hay tareas asignadas para el ${day.toLocal().toString().substring(0, 10)}",
                      textAlign: TextAlign.center,
                    ),
                  )),
          ),
          if (mostrarBotones)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    height: 80,
                    minWidth: 80,
                    onPressed: () {},
                    color: AppTheme.primary,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'Entrada',
                      style: AppTheme.lightTheme.textTheme.labelSmall,
                    ),
                  ),
                  MaterialButton(
                    height: 80,
                    minWidth: 80,
                    onPressed: () async {
                      SecureStorage().deleteSecureData('user');
                    },
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'Salida',
                      style: AppTheme.lightTheme.textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}

class TopTag extends StatelessWidget {
  const TopTag({
    super.key,
    required this.size,
    required this.empleado,
  });

  final Size size;
  final Employee empleado;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 36),
      height: size.height * 0.2 - 27,
      decoration: const BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Row(children: [
        Text(
          '¡Hola ${empleado.name.split(' ')[0]}!',
          style: AppTheme.lightTheme.textTheme.titleSmall!
              .copyWith(color: Colors.white),
        ),
        const Spacer(),
        CircularIconAvatar(
          name: empleado.name,
          radius: 30,
          fontSize: 25,
          backgroundColor: Colors.white,
          textColor: AppTheme.primary,
        )
      ]),
    );
  }
}

class ScheduleTag extends StatelessWidget {
  final List<String> hora;
  const ScheduleTag({
    super.key,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    var horaTag = hora.length > 1 ? "${hora[0]} | ${hora[1]}" : hora[0];
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: ListTile(
        leading: const Icon(Icons.work_history_sharp),
        title: Text(
          horaTag,
          style: const TextStyle(fontSize: 21),
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            '1- Entrada: --:--    Salida: --:--',
            style: TextStyle(fontSize: 18),
          ),
          if (hora.length > 1)
            const Text(
              '2- Entrada: --:--    Salida: --:--',
              style: TextStyle(fontSize: 18),
            )
          else
            const Text(
              '                                  ',
              style: TextStyle(fontSize: 18),
            )
        ]),
        tileColor: AppTheme.primary,
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.size,
    required this.inicialDate,
    required this.setDate,
    required this.day,
    required this.listaHorarios,
    required this.listaTareas,
  });

  final Size size;
  final DateTime day;
  final DateTime inicialDate;
  final Function setDate;
  final List<Schedule> listaHorarios;
  final List<Task> listaTareas;

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: day,
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime(2024, 12, 31),
      onDateSelected: (p0) => setDate(p0, listaHorarios, listaTareas),
      activeDayColor: Colors.white,
      activeBackgroundDayColor: AppTheme.primary,
      dayColor: AppTheme.primary,
      monthColor: AppTheme.primary,
      leftMargin: size.width / 2.5,
    );
  }
}
