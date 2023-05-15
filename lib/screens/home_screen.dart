import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/employee.dart';
import 'package:my_app/services/schedule_services.dart';
import 'package:my_app/services/storage.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool mostrarBotones = true;
  DateTime day = DateTime.now();
  Schedule horario = defaultschedule;

  void setDate(DateTime date, List<Schedule> listaHorario) {
    setState(() {
      day = date;
      var lista = listaHorario
          .where((element) => element.day == day.toString().substring(0, 10));
      horario = lista.isNotEmpty ? lista.first : defaultschedule;
      mostrarBotones = date.day == DateTime.now().day;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Employee empleado =
        Employee.fromJson(ModalRoute.of(context)!.settings.arguments as String);
    final listaHorario = Provider.of<ScheduleService>(context).listaHorario;

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
            onPressed: () => Navigator.pushNamed(context, 'messages'),
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
              TopTag(size: size),
            ],
          ),
          Calendar(
            size: size,
            inicialDate: day,
            setDate: setDate,
            day: day,
            listaHorarios: listaHorario,
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
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.book, size: 30),
                  title: const Text('Título: Comprar el pan'),
                  trailing: IconButton(
                    onPressed: () => Navigator.pushNamed(context, 'task'),
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  iconColor: Colors.white,
                  subtitle: const Text(
                    'Estado: Pendiente',
                    style: TextStyle(fontSize: 13),
                  ),
                );
              },
            ),
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
  });

  final Size size;

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
          '¡Hola David!',
          style: AppTheme.lightTheme.textTheme.titleSmall!
              .copyWith(color: Colors.white),
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Text(
            'DF',
            style: TextStyle(fontSize: 25, color: AppTheme.primary),
          ),
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
          style: TextStyle(fontSize: 21),
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
  });

  final Size size;
  final DateTime day;
  final DateTime inicialDate;
  final Function setDate;
  final List<Schedule> listaHorarios;

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: day,
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime(2024, 12, 31),
      onDateSelected: (p0) {
        setDate(p0, listaHorarios);
      },
      activeDayColor: Colors.white,
      activeBackgroundDayColor: AppTheme.primary,
      dayColor: AppTheme.primary,
      monthColor: AppTheme.primary,
      leftMargin: size.width / 2.5,
    );
  }
}
