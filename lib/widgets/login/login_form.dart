import 'package:flutter/material.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'dni': '',
      'password': '',
    };

    var dni = TextEditingController();
    var password = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: myFormKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: Column(
            children: [
              CustomInputField(
                controller: dni,
                prefixIcon: Icons.person,
                labelText: 'DNI',
                hintText: 'DNI del admin',
                formProperty: 'dni',
                formValues: formValues,
              ),
              const SizedBox(height: 40),
              CustomInputField(
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
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  if (!myFormKey.currentState!.validate()) {
                    password.clear();
                    return;
                  }
                  loginProvider.login(dni.text, password.text).then((value) {
                    if (value) {
                      Navigator.pushReplacementNamed(context, 'splash');
                    }
                  });
                },
                style: AppTheme.lightTheme.elevatedButtonTheme.style,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    'Iniciar Sesión',
                    style: AppTheme.lightTheme.textTheme.labelSmall,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
