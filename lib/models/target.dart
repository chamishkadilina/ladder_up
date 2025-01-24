// target_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Target {
  String? id;
  String title;
  String description;
  String userId;

  Target({
    this.id,
    this.title = 'My Target',
    this.description = 'Add your target description here',
    required this.userId,
  });

  factory Target.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Target(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
    };
  }
}
