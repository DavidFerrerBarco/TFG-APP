import 'package:flutter/material.dart';
import 'package:my_app/providers/storage.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeButtonLogs extends StatelessWidget {
  const HomeButtonLogs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            height: 80,
            minWidth: 80,
            onPressed: () {},
            color: AppTheme.primary,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'Entrada',
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
          ),
          MaterialButton(
            height: 80,
            minWidth: 80,
            onPressed: () async {
              SecureStorage().deleteSecureData('user');
            },
            color: AppTheme.redColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'Salida',
              style: AppTheme.lightTheme.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
