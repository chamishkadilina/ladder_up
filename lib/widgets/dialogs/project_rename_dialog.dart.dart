import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:provider/provider.dart';

void showProjectRenameDialog(BuildContext context, Project project) {
  final TextEditingController controller =
      TextEditingController(text: project.name);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rename Project'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Project Name',
            hintText: 'Enter new project name',
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
                final oldName = project.name; // Store the old name
                final newName = controller.text; // Store the new name

                // Call provider's method to rename the project
                Provider.of<ProjectProvider>(context, listen: false)
                    .renameProject(project, newName);

                // Close dialog
                Navigator.of(context).pop();

                // Show friendly SnackBar message
                showCustomSnackBar(
                  context,
                  'Project "$oldName" has been successfully renamed to "$newName".',
                );
              } else {
                // Show error if input is empty
                showCustomSnackBar(
                  context,
                  'Project name cannot be empty. Please try again.',
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
