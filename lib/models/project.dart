import 'package:ladder_up/models/subtask.dart';

class Project {
  final String title;
  List<Subtask> subtasks;

  Project({
    required this.title,
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];
}
