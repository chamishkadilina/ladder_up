import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:table_calendar/table_calendar.dart';

class ProjectProvider extends ChangeNotifier {
  final List<Project> _projects = [];

  // Get all project list
  List<Project> get projects => _projects;

  // Get completed tasks from a project
  List<Subtask> getCompletedTasks(Project project) {
    return project.subtasks.where((task) => task.isCompleted).toList();
  }

  // Get incomplete tasks from a project
  List<Subtask> getIncompleteTasks(Project project) {
    return project.subtasks.where((task) => !task.isCompleted).toList();
  }

  // Get today tasks
  List<Subtask> getTasksForToday() {
    DateTime today = DateTime.now();
    List<Subtask> todayTasks = [];

    for (var project in projects) {
      final projectTasks = project.subtasks.where((task) {
        if (task.taskdateTime == null) return false;
        return isSameDay(task.taskdateTime!, today);
      }).toList();
      todayTasks.addAll(projectTasks);
    }

    return todayTasks;
  }

  // Get project start date (first task date)
  DateTime? getProjectStartDate(Project project) {
    if (project.subtasks.isEmpty) return null;
    final sortedTasks = project.subtasks
      ..sort((a, b) =>
          a.taskdateTime?.compareTo(b.taskdateTime ?? DateTime.now()) ?? 0);
    return sortedTasks.first.taskdateTime;
  }

  // Get project end date (last task date)
  DateTime? getProjectEndDate(Project project) {
    if (project.subtasks.isEmpty) return null;
    final sortedTasks = project.subtasks
      ..sort((a, b) =>
          b.taskdateTime?.compareTo(a.taskdateTime ?? DateTime.now()) ?? 0);
    return sortedTasks.first.taskdateTime;
  }

  // Add a project
  void addProject(String title, {IconData? icon}) {
    _projects.add(Project(name: title, icon: icon!));
    notifyListeners();
  }

  // Add a task for a project
  void addTask(Project project, String taskName, {DateTime? date}) {
    final newSubtask = Subtask(title: taskName, taskdateTime: date);
    project.subtasks.add(newSubtask);
    notifyListeners();
  }

  // Remove a project
  void removeProject(Project project) {
    _projects.remove(project);
    notifyListeners();
  }

  // Rename project
  void renameProject(Project project, String newName) {
    final index = _projects.indexOf(project);
    if (index != -1) {
      // Update the name
      _projects[index].name = newName;
      notifyListeners();
    }
  }

  // Rename task
  void renameTask(Project project, Subtask task, String newTitle) {
    final taskIndex = project.subtasks.indexOf(task);
    if (taskIndex != -1) {
      project.subtasks[taskIndex].title = newTitle;
      notifyListeners();
    }
  }

  // remove a task from a project
  void removeTask(Project project, Subtask task) {
    project.subtasks.remove(task);
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskStatus(Project project, Subtask task) {
    final taskIndex = project.subtasks.indexOf(task);
    if (taskIndex != -1) {
      task.isCompleted = !task.isCompleted;
      notifyListeners();
    }
  }

  // Reorder task to a specific position
  void reorderTask(Project project, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Subtask task = project.subtasks.removeAt(oldIndex);
    project.subtasks.insert(newIndex, task);
    notifyListeners();
  }
}
