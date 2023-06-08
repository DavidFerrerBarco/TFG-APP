import 'package:flutter/material.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';
import 'package:my_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Employee empleado = ModalRoute.of(context)!.settings.arguments as Employee;
    final GlobalKey<FormState> myFormRequestKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {'title': '', 'content': ''};
    final RequestProvider requestProvider =
        Provider.of<RequestProvider>(context);
    var title = TextEditingController();
    var content = TextEditingController();

    return Scaffold(
      drawer: CommonDrawer(empleado: empleado),
      appBar: AppBar(
        elevation: 0,
        title: const Text("Nueva Solicitud"),
      ),
      body: Form(
        key: myFormRequestKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                CustomInputField(
                  controller: title,
                  prefixIcon: Icons.title,
                  labelText: 'Título',
                  hintText: 'Título de la solicitud',
                  formProperty: 'title',
                  formValues: formValues,
                  maxLines: 2,
                ),
                const SizedBox(height: 60),
                CustomInputField(
                  controller: content,
                  labelText: 'Descripción',
                  hintText: 'Descripción de la solicitud',
                  formProperty: 'content',
                  formValues: formValues,
                  maxLines: 12,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    if (!myFormRequestKey.currentState!.validate()) {
                      return;
                    }
                    requestProvider
                        .sendRequest(empleado, title.text, content.text)
                        .listen((value) {
                      if (value) {
                        Navigator.popAndPushNamed(
                          context,
                          'myrequest',
                          arguments: empleado,
                        );
                      }
                    });
                  },
                  style: AppTheme.lightTheme.elevatedButtonTheme.style,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
