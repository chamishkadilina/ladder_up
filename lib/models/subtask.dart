class Subtask {
  final String title;
  bool isCompleted;
  DateTime? taskdateTime;

  Subtask({
    required this.title,
    this.isCompleted = false,
    this.taskdateTime,
  });
}
