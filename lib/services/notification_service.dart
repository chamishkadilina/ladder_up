import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    if (kDebugMode) {
      print("Notification receive");
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminder Channel',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> scheduleDailyTaskNotification(
      List<Subtask> todayTasks, List<Project> projects) async {
    // If no tasks, send a "no tasks" notification
    if (todayTasks.isEmpty) {
      await scheduleNotification(
          0,
          'No Tasks Today',
          'You have no tasks scheduled for today.',
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 21, 05 // 5:00 AM
              ));
    } else {
      // Create a detailed task notification with project names
      List<String> taskDetails = todayTasks.map((task) {
        // Find the project for this task
        Project? project = projects.firstWhere(
          (p) => p.subtasks.contains(task),
          orElse: () =>
              Project(name: 'Unnamed Project', userId: '', emoji: '📁'),
        );

        return '• ${task.title} (${project.emoji} ${project.name})';
      }).toList();

      String taskMessage = taskDetails.join('\n');

      await scheduleNotification(
          0,
          'Today\'s Tasks',
          'You have ${todayTasks.length} task(s) today:\n$taskMessage',
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 21, 05 // 5:00 AM
              ));
    }
  }
}
