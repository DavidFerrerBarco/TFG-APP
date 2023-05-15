import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/services/storage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Future<void> fetchUserData() {
    return SecureStorage().readSecureData('user');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([SplashScreen.fetchUserData()]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data[0] == jsonEncode(defaultemployee)) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, 'login');
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              print(snapshot.data[0]);
              Navigator.pushReplacementNamed(context, 'home',
                  arguments: snapshot.data[0]);
            });
          }
        }
        return Text('loading...');
      },
    );
  }
}
