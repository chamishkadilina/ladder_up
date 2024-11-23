import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';

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

  // Add a project
  void addProject(String title) {
    _projects.add(Project(title: title));
    notifyListeners();
  }

  // Add a task for a project
  void addTask(Project project, String taskTitle) {
    final subtask = Subtask(title: taskTitle);
    project.subtasks.add(subtask);
    notifyListeners();
  }

  // remove a project
  void removeProject(Project project) {
    _projects.remove(project);
    notifyListeners();
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
