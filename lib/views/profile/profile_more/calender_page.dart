import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  var dateNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calender"),
      ),
      body: Column(
        children: [
          Card(
            child: TableCalendar(
              calendarBuilders: const CalendarBuilders(),
              weekNumbersVisible: false,
              focusedDay: DateTime.now(),
              lastDay: DateTime(2050,12,2),
              firstDay: DateTime(1965,12,2),
              calendarStyle: const CalendarStyle(),
              headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: ''),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                  formatButtonVisible: false,
                  titleCentered: true
              ),
              daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(fontWeight: FontWeight.bold),weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                print(date.toUtc());
              },
              // rangeStartDay: DateTime.now(),
              // rangeEndDay: DateTime(dateNow.year,dateNow.month,dateNow.day + 7),
            ),
          )
        ],
      ),
    );
  }
}
