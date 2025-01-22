import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/services/notification_settings_service.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    if (kDebugMode) {
      print("Notification received");
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
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

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
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
    // Check if notifications are enabled
    bool notificationsEnabled =
        await NotificationSettingsService.getNotificationsEnabled();
    if (!notificationsEnabled) {
      await cancelAllNotifications();
      return;
    }

    // Get the stored reminder time
    TimeOfDay? reminderTime =
        await NotificationSettingsService.getReminderTime();
    reminderTime ??= const TimeOfDay(hour: 8, minute: 0);

    // Calculate the next notification time
    final now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      reminderTime.hour,
      reminderTime.minute,
    );

    // If the time has already passed today, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    // Cancel existing notifications before scheduling new ones
    await cancelAllNotifications();

    // If no tasks, send a "no tasks" notification
    if (todayTasks.isEmpty) {
      await scheduleNotification(
        0,
        'No Tasks Today',
        'You have no tasks scheduled for today.',
        scheduledTime,
      );
    } else {
      // Create a detailed task notification with project names
      List<String> taskDetails = todayTasks.map((task) {
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
        scheduledTime,
      );
    }
  }
}
