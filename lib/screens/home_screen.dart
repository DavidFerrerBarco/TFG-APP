import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool mostrarBotones = true;
  DateTime day = DateTime.now();

  void setDate(DateTime date) {
    setState(() {
      day = date;
      mostrarBotones = date.day == DateTime.now().day;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 36),
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
                ),
              ],
            ),
          ),
          Calendar(
            size: size,
            inicialDate: day,
            setDate: setDate,
            day: day,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: ListTile(
              leading: Icon(Icons.work_history_sharp),
              title: Text(
                'Horario: 08:00-17:00',
              ),
              tileColor: AppTheme.primary,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text(
                'Tarea 1: Comprar el pan',
              ),
              tileColor: AppTheme.secondary,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ListTile(
              leading: Icon(Icons.book),
              title: Text(
                'Tarea 2: Sacar al perro',
              ),
              tileColor: AppTheme.secondary,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
          ),
          if (mostrarBotones)
            Row(
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
                  child: const Text('Entrada'),
                ),
                MaterialButton(
                  height: 80,
                  minWidth: 80,
                  onPressed: () {},
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Text('Salida'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu_outlined),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.newspaper_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.inbox_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.chat),
        ),
      ],
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
  });

  final Size size;
  final DateTime day;
  final DateTime inicialDate;
  final Function setDate;

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: day,
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime(2024, 12, 31),
      onDateSelected: (p0) {
        setDate(p0);
      },
      activeDayColor: Colors.white,
      activeBackgroundDayColor: AppTheme.primary,
      dayColor: AppTheme.primary,
      monthColor: AppTheme.primary,
      leftMargin: size.width / 2.5,
    );
  }
}
