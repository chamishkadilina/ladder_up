import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:provider/provider.dart';

void showTaskRenameDialog(BuildContext context, Project project, Subtask task) {
  final TextEditingController controller =
      TextEditingController(text: task.title);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rename Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Task Name',
            hintText: 'Enter new task name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Close dialog
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final oldName = task.title; // Store the old name
                final newName = controller.text; // Store the new name

                // Use the provider method to rename the task
                Provider.of<ProjectProvider>(context, listen: false)
                    .renameTask(project, task, newName);

                // Close dialog
                Navigator.of(context).pop();

                // Show friendly SnackBar message
                showCustomSnackBar(
                  context,
                  'Task "$oldName" has been successfully renamed to "$newName".',
                );
              } else {
                // Show error if input is empty
                showCustomSnackBar(
                  context,
                  'Task name cannot be empty. Please try again.',
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
