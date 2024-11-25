import 'package:flutter/material.dart';
import 'package:ladder_up/widgets/section_header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('My Schedule'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Table calendar view
            TableCalendar(
              firstDay: DateTime.utc(DateTime.now().year, DateTime.january, 1),
              lastDay: DateTime.utc(DateTime.now().year, DateTime.december, 31),
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                defaultDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                weekendDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                todayTextStyle: const TextStyle(
                  color: Colors.blue,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                defaultTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 16),

            // This Day Task
            SectionHeader(
              title: 'This Day Task',
              selectedDate: DateFormat('MMM dd yyyy').format(_focusedDay),
            ),
          ],
        ),
      ),
    );
  }
}
