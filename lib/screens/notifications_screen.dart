import 'package:flutter/material.dart';
import 'package:my_app/services/services.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcementProvider = Provider.of<AnnouncementService>(context).onDisplayAnnouncements;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      backgroundColor: const Color.fromARGB(227, 255, 255, 255),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.builder(
          itemCount: announcementProvider.length,
          itemBuilder: (context, index) {
            return CardsNN(
              hour: announcementProvider[index].date,
              title: announcementProvider[index].title,
              content: announcementProvider[index].content,
            );
          },
        ),
      ),
    );
  }
}
