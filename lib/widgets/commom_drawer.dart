import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    super.key,
    required this.empleado,
  });

  final Employee empleado;

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                  ),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      CircularIconAvatar(
                        name: empleado.name,
                        radius: 45,
                        fontSize: 40,
                        backgroundColor: Colors.white,
                        textColor: AppTheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        empleado.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: AppTheme.primary, fontSize: 22),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'home',
                      arguments: empleado,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                  title: const Text(
                    'Perfil',
                    style: TextStyle(color: AppTheme.primary, fontSize: 22),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'profile',
                      arguments: empleado,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.assignment,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                  title: const Text(
                    'Mis Solicitudes',
                    style: TextStyle(color: AppTheme.primary, fontSize: 22),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'myrequest',
                      arguments: empleado,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.assignment_add,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                  title: const Text(
                    'Nueva Solicitud',
                    style: TextStyle(color: AppTheme.primary, fontSize: 22),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'request',
                      arguments: empleado,
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: const Icon(
                Icons.home,
                color: AppTheme.redColor,
                size: 30,
              ),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: AppTheme.redColor, fontSize: 22),
              ),
              onTap: () {
                homeProvider.logout.listen((value) {
                  if (value) {
                    Navigator.popAndPushNamed(context, 'splash');
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
