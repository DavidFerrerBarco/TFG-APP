import 'package:flutter/material.dart';
import 'package:my_app/services/news_services.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsService>(context).onDisplayNews;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      backgroundColor: const Color.fromARGB(227, 255, 255, 255),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.builder(
          itemCount: newsProvider.length,
          itemBuilder: (context, index) {
            return CardsNN(
              hour: newsProvider[index].date,
              title: newsProvider[index].title,
              content: newsProvider[index].content,
            );
          },
        ),
      ),
    );
  }
}
