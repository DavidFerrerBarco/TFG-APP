import 'package:flutter/material.dart';
import 'package:my_app/theme/app_theme.dart';
import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Diary',
      initialRoute: 'home',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => HomeScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
