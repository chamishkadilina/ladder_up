import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:provider/provider.dart';

class TaskListRegular extends StatelessWidget {
  final List<Subtask> tasks;

  const TaskListRegular({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);

    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'No tasks available',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final project = projectProvider.projects.firstWhere(
          (p) => p.subtasks.contains(task),
        );

        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: IconButton(
            onPressed: () {
              // Handle more options
            },
            icon: const Icon(Icons.more_vert),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (value) {
              projectProvider.toggleTaskStatus(project, task);
            },
          ),
        );
      },
    );
  }
}
