import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AnnouncementProvider announcementProvider =
        Provider.of<AnnouncementProvider>(context);
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Anuncio')),
      backgroundColor: const Color.fromARGB(227, 255, 255, 255),
      body: StreamBuilder(
        stream: announcementProvider.getAnuncios(empleado),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<Announcement> anuncios = snapshot.data!;
            if (anuncios != [defaultannouncement]) {
              anuncios = anuncios.reversed.toList();
              return SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: anuncios.length,
                  itemBuilder: (context, index) {
                    return CustomCards(
                      hour: anuncios[index].date,
                      title: anuncios[index].title,
                      content: anuncios[index].content,
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "NO HAY ANUNCIOS",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              );
            }
          } else {
            return const CustomCircularProgress();
          }
        },
      ),
    );
  }
}
