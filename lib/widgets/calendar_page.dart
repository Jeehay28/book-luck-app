import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _recordedDays = {
    DateTime.utc(2025, 7, 3),
    DateTime.utc(2025, 7, 5),
    DateTime.utc(2025, 7, 9),
    DateTime.utc(2025, 7, 10),
    DateTime.utc(2025, 7, 11),
  };

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '이번 달 기록',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        TableCalendar(
          // locale: 'ko_KR',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) =>
              _isSameDay(_selectedDay ?? _focusedDay, day),
          calendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: false,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          calendarStyle: const CalendarStyle(
            isTodayHighlighted: false,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.black),
            weekdayStyle: TextStyle(color: Colors.black),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final bool isRecorded =
                  _recordedDays.any((d) => _isSameDay(d, day));
              final bool isToday = _isSameDay(day, today);

              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isRecorded)
                      SvgPicture.asset(
                        'assets/images/black_clover.svg', // Your SVG image path
                        width: 40,
                        height: 40,
                      ),
                    // else if (isToday)
                    //   SvgPicture.asset(
                    //     'assets/images/grey_clover.svg', // Your SVG image path
                    //     width: 40,
                    //     height: 40,
                    //   ),
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: isRecorded
                            ? Colors.white
                            : Color(0xff303030).withAlpha((0.4 * 255).round()),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
