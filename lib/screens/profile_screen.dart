import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'password': '',
    };
    final ProfilerProvider profilerProvider =
        Provider.of<ProfilerProvider>(context);
    var password = TextEditingController();
    return Scaffold(
      drawer: CommonDrawer(empleado: empleado),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Perfil"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircularIconAvatar(
                  name: empleado.name,
                  radius: 60,
                  fontSize: 50,
                  backgroundColor: AppTheme.primary,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  empleado.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const Divider(
                  color: AppTheme.secondary,
                  thickness: 3,
                ),
                const Text(
                  "DNI",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Text(
                  empleado.dni,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                const Text(
                  "EMPRESA",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Text(
                  empleado.company,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "EMAIL",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Text(
                  empleado.email,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "CONTRATO",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Text(
                  "${empleado.contract} horas semanales",
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const Divider(
                  color: AppTheme.secondary,
                  thickness: 3,
                ),
                const Text(
                  "Cambiar Contraseña",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10),
                Form(
                  key: myFormKey,
                  child: CustomInputField(
                    controller: password,
                    suffixIcon: Icons.remove_red_eye_rounded,
                    prefixIcon: Icons.lock_outline_rounded,
                    labelText: 'Password',
                    hintText: 'Password',
                    formProperty: 'password',
                    formValues: formValues,
                    isPassword: true,
                    allowPassword: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!myFormKey.currentState!.validate()) {
                      password.clear();
                      return;
                    }
                    profilerProvider
                        .newPassword(empleado, password.text)
                        .listen((value) {
                      if (value != defaultemployee) {
                        Navigator.popAndPushNamed(
                          context,
                          'profile',
                          arguments: empleado,
                        );
                      }
                    });
                  },
                  style: AppTheme.lightTheme.elevatedButtonTheme.style,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Nueva Contraseña',
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
