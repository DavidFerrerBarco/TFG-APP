import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

class HomeUserTag extends StatelessWidget {
  const HomeUserTag({
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
