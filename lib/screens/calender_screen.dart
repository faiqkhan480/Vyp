import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: CellCalendar(
          events: [
            CalendarEvent(eventName: "Event 1",eventDate: DateTime(2022, 4, 15)),
            CalendarEvent(eventName: "Event 2",eventDate: DateTime(2022, 4, 20)),
          ],
          daysOfTheWeekBuilder: (dayIndex) {
            /// dayIndex: 0 for Sunday, 6 for Saturday.
            final labels = ["S", "M", "T", "W", "T", "F", "S"];
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                labels[dayIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
          monthYearLabelBuilder: (DateTime? datetime) {
            final year = datetime!.year.toString();
            final month = datetime.month.toString();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "$month, $year",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
