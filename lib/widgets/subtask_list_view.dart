import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/providers/project_provider.dart';

class SubtaskListView extends StatelessWidget {
  const SubtaskListView({
    super.key,
    required this.tasks,
    required this.projectProvider,
    required this.project,
  });

  final List<Subtask> tasks;
  final ProjectProvider projectProvider;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final subtask = tasks[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          title: Text(
            subtask.title,
            style: TextStyle(
              decoration: subtask.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: subtask.isCompleted ? Colors.grey : Colors.black,
            ),
          ),
          trailing: Checkbox(
            value: subtask.isCompleted,
            onChanged: (value) {
              projectProvider.toggleTaskStatus(project, subtask);
            },
          ),
        );
      },
    );
  }
}
