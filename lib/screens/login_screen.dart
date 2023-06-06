import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        LoginBackground(
          primaryColor: Color.fromARGB(255, 223, 223, 223),
          secondaryColor: AppTheme.primary,
          right: 100,
          bottom: 100,
        ),
        LoginContent(),
      ],
    );
  }
}
