import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none),
              ),
            ),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              clipBehavior: Clip.antiAlias,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
