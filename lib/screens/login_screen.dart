import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _BackGround(
          primaryColor: Color.fromARGB(255, 223, 223, 223),
          secondaryColor: AppTheme.primary,
          right: 100,
          bottom: 100,
        ),
        _Content(),
      ],
    );
  }
}

class _BackGround extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final double right;
  final double bottom;

  const _BackGround(
      {super.key,
      required this.primaryColor,
      required this.secondaryColor,
      required this.right,
      required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: primaryColor),
        Positioned(
          right: right,
          bottom: bottom,
          child: _ColorBoxRotated(
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}

class _ColorBoxRotated extends StatelessWidget {
  final Color color;

  const _ColorBoxRotated({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 5,
      child: Container(
        width: 600,
        height: 1000,
        color: color,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {'dni': '1234', 'password': '1234'};

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "Bienvenido a Employee Diary",
              style: AppTheme.lightTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Iniciar Sesión",
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ),
            Container(
              width: 400,
              height: 400,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Form(
                    key: myFormKey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 40),
                      child: Column(
                        children: [
                          CustomInputField(
                            labelText: 'DNI',
                            hintText: 'DNI del empleado',
                            formProperty: 'dni',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 40),
                          CustomInputField(
                            labelText: 'Password',
                            hintText: 'Password del empleado',
                            formProperty: 'password',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 80),
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              if (!myFormKey.currentState!.validate()) {
                                return;
                              }
                              Navigator.pushNamed(context, 'home');
                            },
                            style:
                                AppTheme.lightTheme.elevatedButtonTheme.style,
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text('Iniciar Sesión')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
