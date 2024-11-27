import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/models/subtask.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:provider/provider.dart';

void showTaskEditDialog(BuildContext context, Project project, Subtask task) {
  final TextEditingController titleController =
      TextEditingController(text: task.title);
  DateTime selectedDate = task.taskdateTime ?? DateTime.now();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Task Rename Section
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                hintText: 'Enter new task name',
              ),
            ),
            const SizedBox(height: 20),

            // Task Date Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Selected Date:'),
                Text(
                  DateFormat('MMM dd, yyyy').format(selectedDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: const Text('Pick a New Date'),
              onPressed: () async {
                // Open the Date Picker
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (newDate != null) {
                  selectedDate = newDate; // Update the selected date
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog without saving
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newTitle = titleController.text.trim();
              if (newTitle.isEmpty) {
                // Show error if the task name is empty
                showCustomSnackBar(
                  context,
                  'Task name cannot be empty. Please try again.',
                );
                return;
              }

              // Update task title if it has changed
              if (newTitle != task.title) {
                Provider.of<ProjectProvider>(context, listen: false)
                    .renameTask(project, task, newTitle);
              }

              // Update task date if it has changed
              if (selectedDate != task.taskdateTime) {
                Provider.of<ProjectProvider>(context, listen: false)
                    .updateTaskDate(project, task, selectedDate);
              }

              // Close the dialog
              Navigator.of(context).pop();

              // Show success SnackBar
              showCustomSnackBar(
                context,
                'Task updated successfully: '
                '"$newTitle" with date ${DateFormat('MMM dd, yyyy').format(selectedDate)}.',
              );
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
