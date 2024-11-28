class Subtask {
  String? id; // Add Firestore document ID
  String title;
  bool isCompleted;
  DateTime? taskdateTime;

  Subtask({
    this.id,
    required this.title,
    this.isCompleted = false,
    this.taskdateTime,
  });

  // Convert Subtask to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'taskdateTime': taskdateTime?.toIso8601String(),
    };
  }

  // Create Subtask from Firestore document
  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
      taskdateTime: map['taskdateTime'] != null
          ? DateTime.parse(map['taskdateTime'])
          : null,
    );
  }
}
