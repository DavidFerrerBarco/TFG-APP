import 'models/models.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleService(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskService();
        ),
        ChangeNotifierProvider(
          create: (_) => AnnouncementService();
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Diary',
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const SplashScreen(),
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
        'messages': (_) => const MessagesScreen(),
        'news': (_) => const NewsScreen(),
        'notifications': (_) => const NotificationScreen(),
        'task': (_) => const TaskScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
