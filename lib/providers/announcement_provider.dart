import 'package:flutter/material.dart';
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;

class AnnouncementProvider extends ChangeNotifier {
  Stream<List<Announcement>> getAnuncios(Employee empleado) async* {
    await Future.delayed(const Duration(milliseconds: 500));
    String validCompany = empleado.company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, '/api/announcement/company/$validCompany');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${empleado.token}',
        },
      );
      if (response.statusCode == 200) {
        final AnnouncementModel announcementModel =
            AnnouncementModel.fromJson(response.body);
        yield announcementModel.data;
      } else {
        yield <Announcement>[];
      }
    } catch (error) {
      yield [defaultannouncement];
    }
  }
}
