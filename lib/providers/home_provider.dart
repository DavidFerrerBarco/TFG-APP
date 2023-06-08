import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/constants/constants.dart';
import 'package:my_app/models/models.dart';
import 'package:my_app/providers/providers.dart';

class HomeProvider extends ChangeNotifier {
  bool _autorizacion = true;

  Stream<bool> get autorizacion async* {
    yield _autorizacion;
  }

  void setNewAuthorization(bool newauth) {
    _autorizacion = newauth;
    notifyListeners();
  }

  // -----------------------------------------------------------------------

  bool _mostrarBotones = true;

  Stream<bool> get mostrarBotones async* {
    yield _mostrarBotones;
  }

  void sePuedenMostrar(DateTime dia) {
    _mostrarBotones = dia.day == DateTime.now().day;
  }

  // -----------------------------------------------------------------------

  DateTime _diaSeleccionado = DateTime.now();

  Stream<DateTime> get diaSeleccionado async* {
    yield _diaSeleccionado;
  }

  void setDia(DateTime nuevoDia) {
    _diaSeleccionado = nuevoDia;
  }

  // ------------------------------------------------------------------------

  List<Schedule> _horarios = <Schedule>[];

  void setHorarios(List<Schedule> listahorarios) {
    _horarios = listahorarios;
  }

  Schedule _horariosDelDia = defaultschedule;

  Stream<Schedule> get horariosDelDia async* {
    yield _horariosDelDia;
  }

  void setHorariosDelDia(DateTime dia) {
    List<Schedule> nuevaLista = _horarios
        .where((element) => element.day == dia.toString().substring(0, 10))
        .toList();

    _horariosDelDia =
        nuevaLista.isNotEmpty ? nuevaLista.first : defaultschedule;
  }

  // ------------------------------------------------------------------------

  List<Task> _tareas = <Task>[];

  void setTareas(List<Task> listaTareas) {
    _tareas = listaTareas;
  }

  List<Task> _tareasDelDia = defaulttasks;

  Stream<List<Task>> get tareasDelDia async* {
    yield _tareasDelDia;
  }

  void setTareasDelDia(DateTime dia) {
    List<Task> nuevaLista = _tareas
        .where((element) => element.day == dia.toString().substring(0, 10))
        .toList();

    _tareasDelDia = nuevaLista.isNotEmpty ? nuevaLista : defaulttasks;
  }

  // -----------------------------------------------------------------------
  void setAllData(DateTime dia) {
    setHorariosDelDia(dia);
    setTareasDelDia(dia);
    setDia(dia);
    sePuedenMostrar(dia);
    notifyListeners();
  }

  // ------------------------------------------------------------------------

  Stream<bool> getListaHorarios(Employee empleado) async* {
    try {
      if (empleado.token != null) {
        var url = Uri.http(baseUrl, '/api/schedule/employee/${empleado.id}');
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${empleado.token}',
          },
        );
        if (response.statusCode == 401) {
          setNewAuthorization(false);
          yield false;
        } else {
          final ScheduleModel scheduleResponse =
              ScheduleModel.fromJson(response.body);
          setHorarios(scheduleResponse.data);
          setHorariosDelDia(_diaSeleccionado);
          yield true;
        }
      } else {
        setNewAuthorization(false);
        yield false;
      }
    } catch (error) {
      yield false;
    }
  }

  // -----------------------------------------------------------------------
  Stream<bool> getListaTareas(Employee empleado) async* {
    try {
      if (empleado.token != null) {
        var url = Uri.http(baseUrl, '/api/task/employee/${empleado.id}');
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer ${empleado.token}',
          },
        );
        if (response.statusCode == 401) {
          setNewAuthorization(false);
          yield false;
        } else {
          final TaskModel taskResponse = TaskModel.fromJson(response.body);
          setTareas(taskResponse.data);
          setTareasDelDia(_diaSeleccionado);
          yield true;
        }
      } else {
        setNewAuthorization(false);
        yield false;
      }
    } catch (error) {
      yield false;
    }
  }

  // ---------------------------------------------------------------------
  Stream<bool> putHours(Schedule horario) async* {
    String hora = DateTime.now().toString().substring(11, 16);
    int index = horario.realHours.indexWhere((element) => element == '--:--');

    List<String> nuevaLista = horario.realHours;
    nuevaLista[index] = hora;

    try {
      var url = Uri.http(baseUrl, '/api/schedule/${horario.id}');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "realHours": nuevaLista,
        }),
      );
      if (response.statusCode == 200) {
        final ScheduleModel scheduleModel =
            ScheduleModel.fromJson(response.body);
        setHorarios(scheduleModel.data);
        notifyListeners();
        yield true;
      } else {
        yield false;
      }
    } catch (error) {
      yield false;
    }
  }

  // ---------------------------------------------------------------------

  Stream<bool> get logout async* {
    try {
      await SecureStorage().deleteSecureData('user');
      yield true;
    } catch (error) {
      yield false;
    }
  }
}
