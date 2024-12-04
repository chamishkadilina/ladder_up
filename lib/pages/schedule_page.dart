import 'package:flutter/material.dart';
import 'package:ladder_up/widgets/dialogs/add_task_with_project_selection_dialog.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:ladder_up/widgets/task_list_regular.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/widgets/section_header.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Helper method to get tasks for selected date
  List<Subtask> _getTasksForSelectedDate(ProjectProvider provider) {
    if (_selectedDay == null) return [];

    List<Subtask> todayTasks = [];

    for (var project in provider.projects) {
      final projectTasks = project.subtasks.where((task) {
        if (task.taskdateTime == null) return false;
        return isSameDay(task.taskdateTime!, _selectedDay!);
      }).toList();
      todayTasks.addAll(projectTasks);
    }

    return todayTasks;
  }

  // Helper method to get number of tasks for a specific day
  List<dynamic> _getEventsForDay(DateTime day, ProjectProvider provider) {
    int taskCount = 0;
    for (var project in provider.projects) {
      taskCount += project.subtasks
          .where((task) =>
              task.taskdateTime != null && isSameDay(task.taskdateTime!, day))
          .length;
    }
    // Return a list with length equal to number of tasks
    return List.generate(taskCount, (index) => 'task');
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F8),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Consumer<ProjectProvider>(
        builder: (context, projectProvider, child) {
          final tasksForSelectedDate =
              _getTasksForSelectedDate(projectProvider);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                // Table calendar view
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: TableCalendar(
                    firstDay:
                        DateTime.utc(DateTime.now().year, DateTime.january, 1),
                    lastDay: DateTime.utc(
                        DateTime.now().year, DateTime.december, 31),
                    focusedDay: _focusedDay,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      markersAlignment: Alignment.bottomCenter,
                      markersAnchor: 0.8,
                      markerSize: 8,
                      markerMargin: const EdgeInsets.symmetric(horizontal: 0.8),
                      todayTextStyle: const TextStyle(color: Colors.blue),
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
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
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
                    eventLoader: (day) =>
                        _getEventsForDay(day, projectProvider),
                  ),
                ),
                const SizedBox(height: 16),

                // This Day Task Sectoion
                SectionHeader(
                  title: 'This Day Task',
                  selectedDate: DateFormat('MMM dd yyyy').format(_selectedDay!),
                  onTap: () {
                    final projectProvider =
                        Provider.of<ProjectProvider>(context, listen: false);
                    final projectNames = projectProvider.projects
                        .map((project) => project.name)
                        .toList();

                    if (projectNames.isEmpty) {
                      // Handle case where no projects are available
                      showCustomSnackBar(context,
                          'Please create a project before adding tasks.');
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => AddTaskWithProjectSelectionDialog(
                        projectNames: projectNames,
                        onTaskAdded: (projectName, taskName, taskDate) {
                          final selectedProject =
                              projectProvider.projects.firstWhere(
                            (project) => project.name == projectName,
                          );
                          projectProvider.addTask(selectedProject, taskName,
                              date: taskDate);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),

                // Task List
                Expanded(
                  child: TaskListRegular(
                    tasks: tasksForSelectedDate,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
