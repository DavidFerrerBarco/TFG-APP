import '../constants/constants.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnnouncementService extends ChangeNotifier{
  List<Announcement> onDisplayAnnouncements = [];

  AnnouncementService(){
    getAllAnnouncement();
  }

  getAllAnnouncement() async {
    var empleado = Employee.fromJson(await SecureStorage().readSecureData('user'));
    var company = empleado.company.replace(' ', '-');
    if(empleado.token != null){
      var url = Uri.http(baseUrl, '/api/announcement/company/$company')

      final response = await http.get(url);
      final announcementResponse = AnnouncementModel.fromJson(response.body);

      onDisplayAnnouncements = announcementResponse.data;

      notifyListeners();
    }
  }
}