import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeScheduleTag extends StatelessWidget {
  final List<String> hora;
  const HomeScheduleTag({
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
