import 'package:flutter/material.dart';
import 'package:ladder_up/models/subtask.dart';

class Project {
  final String title;
  IconData? icon;
  List<Subtask> subtasks;

  Project({
    required this.title,
    this.icon,
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];
}
