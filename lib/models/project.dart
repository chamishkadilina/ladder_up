import 'package:flutter/material.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String? id; // Add Firestore document ID
  String name;
  final IconData icon;
  List<Subtask> subtasks;
  String? userId; // Add user ID to associate project with user

  Project({
    this.id,
    required this.name,
    required this.icon,
    List<Subtask>? subtasks,
    this.userId,
  }) : subtasks = subtasks ?? [];

  // Convert Project to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.codePoint,
      'userId': userId,
      'subtasks': subtasks.map((task) => task.toMap()).toList(),
    };
  }

  // Create Project from Firestore document
  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Project(
      id: doc.id,
      name: data['name'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
      subtasks: (data['subtasks'] as List?)
              ?.map((taskMap) => Subtask.fromMap(taskMap))
              .toList() ??
          [],
      userId: data['userId'],
    );
  }
}
