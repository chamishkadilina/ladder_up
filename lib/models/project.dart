import 'package:flutter/material.dart';
import 'package:ladder_up/models/subtask.dart';

class Project {
  final String name;
  final IconData icon;
  List<Subtask> subtasks;

  Project({
    required this.name,
    required this.icon,
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];
}
