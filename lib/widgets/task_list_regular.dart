import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/theme/custom_themes/text_theme.dart';
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
          Text(
            'Keep moving forward!\nTap + to add your next task to stay on track.',
            textAlign: TextAlign.center,
            style: Theme.of(context).brightness == Brightness.dark
                ? MyTextTheme.darkTextTheme.bodySmall
                : MyTextTheme.lightTextTheme.bodySmall,
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
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF151515)
                  : Colors.white,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_document,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Edit Task',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            'Delete Task',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isCompleted
                            ? Colors.grey
                            : Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF151515),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
