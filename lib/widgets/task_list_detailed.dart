import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/dialogs/task_delete_dialog.dart';
import 'package:ladder_up/widgets/dialogs/task_edit_dialog.dart';

class TaskListDetailed extends StatelessWidget {
  const TaskListDetailed({
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
        final task = tasks[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                showTaskEditDialog(context, project, task);
              } else if (value == 'delete') {
                showTaskDeleteDialog(context, projectProvider, project, task);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_document, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Edit Task'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Task'),
                  ],
                ),
              ),
            ],
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.isCompleted ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: task.taskdateTime != null
              ? Text(
                  DateFormat('dd MMM yyyy').format(task.taskdateTime!),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )
              : null,
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
