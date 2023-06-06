import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/theme/app_theme.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({
    super.key,
    required this.size,
    required this.inicialDate,
    required this.homeProvider,
  });

  final Size size;
  final DateTime inicialDate;
  final HomeProvider homeProvider;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.homeProvider.diaSeleccionado,
      builder: (context, snapshot) {
        return CalendarTimeline(
          initialDate: snapshot.hasData ? snapshot.data! : DateTime.now(),
          firstDate: DateTime(2020, 01, 01),
          lastDate: DateTime(2024, 12, 31),
          onDateSelected: (p0) => widget.homeProvider.setAllData(p0),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: AppTheme.primary,
          dayColor: AppTheme.primary,
          monthColor: AppTheme.primary,
          leftMargin: widget.size.width / 2.5,
        );
      },
    );
  }
}
