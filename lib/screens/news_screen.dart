import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewProvider newProvider = Provider.of<NewProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias')),
      backgroundColor: const Color.fromARGB(227, 255, 255, 255),
      body: StreamBuilder(
        stream: newProvider.getNoticias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<News> noticias = snapshot.data!;
            if (noticias != [defaultnews]) {
              noticias = noticias.reversed.toList();
              return SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: noticias.length,
                  itemBuilder: (context, index) {
                    return CustomCards(
                      hour: noticias[index].date,
                      title: noticias[index].title,
                      content: noticias[index].content,
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "NO HAY NOTICIAS",
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
