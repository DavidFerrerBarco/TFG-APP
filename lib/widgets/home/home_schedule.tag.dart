import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeScheduleTag extends StatelessWidget {
  final List<String> hora;
  final List<String> realHours;
  final Color color;
  const HomeScheduleTag({
    super.key,
    required this.hora,
    required this.realHours,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var horaTag = hora.isNotEmpty
        ? hora.length > 1
            ? "${hora[0]} | ${hora[1]}"
            : hora[0]
        : "";
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: ListTile(
        leading: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Icon(
            Icons.work_history_sharp,
            size: 30,
          ),
        ),
        title: Text(
          horaTag,
          style: const TextStyle(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hora.isNotEmpty)
              Text(
                '1- Entrada: ${realHours[0]}   Salida: ${realHours[1]}',
                style: const TextStyle(fontSize: 18),
              )
            else
              Text(
                "No hay horario. Día libre.",
                style: TextStyle(fontSize: 18, color: color),
                textAlign: TextAlign.center,
              ),
            if (realHours.length > 2)
              Text(
                '2- Entrada: ${realHours[2]}   Salida: ${realHours[3]}',
                style: const TextStyle(fontSize: 18),
              )
            else
              const Text(
                '                                  ',
                style: TextStyle(fontSize: 18),
              )
          ],
        ),
        tileColor: AppTheme.primary,
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
