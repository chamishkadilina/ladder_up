import 'package:cloud_firestore/cloud_firestore.dart';
import 'subtask.dart';

class Project {
  String id;
  String name;
  String userId;
  String emoji; // Changed to required emoji
  List<Subtask> subtasks;

  Project({
    this.id = '',
    required this.name,
    required this.userId,
    required this.emoji, // Now required instead of optional
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];

  factory Project.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Project(
      id: doc.id,
      name: data['name'] ?? '',
      userId: data['userId'] ?? '',
      emoji: data['emoji'] ?? '📁', // Default emoji if none provided
      subtasks: (data['subtasks'] as List<dynamic>?)
              ?.map((subtaskData) => Subtask.fromMap(subtaskData))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'emoji': emoji,
      'subtasks': subtasks.map((subtask) => subtask.toMap()).toList(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      userId: map['userId'] ?? '',
      emoji: map['emoji'] ?? '📁',
      subtasks: (map['subtasks'] as List<dynamic>?)
              ?.map((subtaskData) =>
                  Subtask.fromMap(Map<String, dynamic>.from(subtaskData)))
              .toList() ??
          [],
    );
  }

  // Add this method for local storage
  Map<String, dynamic> toLocalMap() {
    return {
      'id': id,
      ...toMap(),
    };
  }
}
