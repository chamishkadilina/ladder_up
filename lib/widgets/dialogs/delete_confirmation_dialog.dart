import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snackbar.dart';

void showDeleteConfirmationDialog(
    BuildContext context, ProjectProvider projectProvider, Project project) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Project'),
        content: Text(
            'Are you sure you want to delete the project "${project.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // remove the project
              projectProvider.removeProject(project);
              // Close the dialog
              Navigator.of(context).pop();
              // Navigate back to the previous screen
              Navigator.of(context).pop();
              showCustomSnackBar(
                context,
                duration: const Duration(seconds: 3),
                '${project.name} has been deleted.',
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
