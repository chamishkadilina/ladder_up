import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/widgets/dialogs/task_delete_dialog.dart';
import 'package:ladder_up/widgets/dialogs/task_edit_dialog.dart';
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/ic_notasks.png',
            scale: 2.4,
          ),
          const Text(
            'No tasks available',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 36,
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final project = projectProvider.projects.firstWhere(
          (p) => p.subtasks.contains(task),
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      showTaskEditDialog(context, project, task);
                    } else if (value == 'delete') {
                      showTaskDeleteDialog(
                          context, projectProvider, project, task);
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
                title: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    projectProvider.toggleTaskStatus(project, task);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
