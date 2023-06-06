import 'package:flutter/material.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AnnouncementProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
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
        'notifications': (_) => const AnnouncementScreen(),
        'task': (_) => const TaskScreen(),
        'chat': (_) => const ChatScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
