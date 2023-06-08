import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/employee.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider = Provider.of<SplashProvider>(context);

    return StreamBuilder(
      stream: splashProvider.loading,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String employee = snapshot.data!;
          if (employee == jsonEncode(defaultemployee)) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, 'login');
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, 'home',
                  arguments: Employee.fromJson(employee));
            });
          }
        }
        return const CustomCircularProgress();
      },
    );
  }
}

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
