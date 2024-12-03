import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:table_calendar/table_calendar.dart';

class ProjectProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Project> _projects = [];

  // Get all project list
  List<Project> get projects => _projects;

  // Fetch projects for the current user
  Future<void> fetchProjects() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('projects')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      _projects =
          querySnapshot.docs.map((doc) => Project.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  // Add a project to Firestore with emoji
  Future<void> addProject(String title, {required String emoji}) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      final newProject = Project(
        name: title,
        emoji: emoji,
        userId: currentUser.uid,
      );

      DocumentReference docRef =
          await _firestore.collection('projects').add(newProject.toMap());

      newProject.id = docRef.id;
      _projects.add(newProject);
      notifyListeners();
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  // Remove project from Firestore
  Future<void> removeProject(Project project) async {
    try {
      await _firestore.collection('projects').doc(project.id).delete();
      _projects.remove(project);
      notifyListeners();
    } catch (e) {
      print('Error removing project: $e');
    }
  }

  // Rename project and update in Firestore
  Future<void> renameProject(Project project, String newName) async {
    try {
      final index = _projects.indexOf(project);
      if (index != -1) {
        _projects[index].name = newName;

        // Update in Firestore
        await _firestore
            .collection('projects')
            .doc(project.id)
            .update({'name': newName});

        notifyListeners();
      }
    } catch (e) {
      print('Error renaming project: $e');
    }
  }

  // Update project in Firestore
  Future<void> updateProject(Project project) async {
    try {
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toMap());
      notifyListeners();
    } catch (e) {
      print('Error updating project: $e');
    }
  }

  // Add a task for a project and update in Firestore
  Future<void> addTask(Project project, String taskName,
      {DateTime? date}) async {
    try {
      final newSubtask = Subtask(title: taskName, taskdateTime: date);
      project.subtasks.add(newSubtask);

      // Update project in Firestore
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toMap());

      notifyListeners();
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  // Remove a task from a project and update in Firestore
  Future<void> removeTask(Project project, Subtask task) async {
    try {
      project.subtasks.remove(task);

      // Update project in Firestore
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toMap());

      notifyListeners();
    } catch (e) {
      print('Error removing task: $e');
    }
  }

  // Rename task and update in Firestore
  Future<void> renameTask(
      Project project, Subtask task, String newTitle) async {
    try {
      final taskIndex = project.subtasks.indexOf(task);
      if (taskIndex != -1) {
        project.subtasks[taskIndex].title = newTitle;

        // Update project in Firestore
        await _firestore
            .collection('projects')
            .doc(project.id)
            .update(project.toMap());

        notifyListeners();
      }
    } catch (e) {
      print('Error renaming task: $e');
    }
  }

  // Toggle task completion status and update in Firestore
  Future<void> toggleTaskStatus(Project project, Subtask task) async {
    try {
      final taskIndex = project.subtasks.indexOf(task);
      if (taskIndex != -1) {
        task.isCompleted = !task.isCompleted;

        // Update project in Firestore
        await _firestore
            .collection('projects')
            .doc(project.id)
            .update(project.toMap());

        notifyListeners();
      }
    } catch (e) {
      print('Error toggling task status: $e');
    }
  }

  // Reorder task to a specific position and update in Firestore
  Future<void> reorderTask(Project project, int oldIndex, int newIndex) async {
    try {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Subtask task = project.subtasks.removeAt(oldIndex);
      project.subtasks.insert(newIndex, task);

      // Update project in Firestore
      await _firestore
          .collection('projects')
          .doc(project.id)
          .update(project.toMap());

      notifyListeners();
    } catch (e) {
      print('Error reordering task: $e');
    }
  }

  // Update task date and sync with Firestore
  Future<void> updateTaskDate(
      Project project, Subtask task, DateTime newDate) async {
    try {
      final taskIndex = project.subtasks.indexOf(task);
      if (taskIndex != -1) {
        project.subtasks[taskIndex].taskdateTime = newDate;

        // Update project in Firestore
        await _firestore
            .collection('projects')
            .doc(project.id)
            .update(project.toMap());

        notifyListeners();
      }
    } catch (e) {
      print('Error updating task date: $e');
    }
  }

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
}
