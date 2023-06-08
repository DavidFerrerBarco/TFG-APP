import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeButtonLogs extends StatelessWidget {
  const HomeButtonLogs({
    super.key,
    required this.empleado,
    required this.horario,
    required this.homeProvider,
  });

  final Employee empleado;
  final Schedule horario;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    Color color;
    String texto;

    if (horario.realHours.indexWhere((element) => element == '--:--').isEven) {
      color = AppTheme.primary;
      texto = "Entrada";
    } else {
      color = AppTheme.redColor;
      texto = "Salida";
    }

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: MaterialButton(
        height: 100,
        minWidth: 100,
        onPressed: () {
          homeProvider.putHours(horario).listen((value) {});
        },
        color: color,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Text(
          texto,
          style: AppTheme.lightTheme.textTheme.labelSmall,
        ),
      ),
    );
  }
}
