import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';

void showTaskDeleteDialog(BuildContext context, ProjectProvider projectProvider,
    Project project, Subtask task) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Task'),
        content: Text(
            'Are you sure you want to delete the task "${task.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // remove the task
              projectProvider.removeTask(project, task);
              // Close the dialog
              Navigator.of(context).pop();

              // Show a snackbar to confirm deletion
              showCustomSnackBar(
                context,
                'Task "${task.title}" has been deleted.',
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
