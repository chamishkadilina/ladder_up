import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';

class AddTaskWithProjectSelectionDialog extends StatefulWidget {
  final List<String> projectNames;
  final Function(String projectName, String taskName, DateTime taskDate)
      onTaskAdded;

  const AddTaskWithProjectSelectionDialog({
    super.key,
    required this.projectNames,
    required this.onTaskAdded,
  });

  @override
  State<AddTaskWithProjectSelectionDialog> createState() =>
      _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskWithProjectSelectionDialog> {
  String? selectedProjectName;
  String taskName = '';
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add A Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dropdown for Project Selection
          DropdownButtonFormField<String>(
            value: selectedProjectName,
            decoration: const InputDecoration(
              labelText: "Select Project",
              border: OutlineInputBorder(),
            ),
            items: widget.projectNames.map((projectName) {
              return DropdownMenuItem<String>(
                value: projectName,
                child: Text(projectName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedProjectName = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // TextField for Task Name
          TextField(
            onChanged: (value) {
              taskName = value;
            },
            decoration: const InputDecoration(
              labelText: "Task Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Date Picker for Task Date
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? "Pick a Date"
                        : DateFormat('MMM dd yyyy').format(selectedDate!),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (selectedProjectName != null &&
                taskName.isNotEmpty &&
                selectedDate != null) {
              widget.onTaskAdded(
                selectedProjectName!,
                taskName,
                selectedDate!,
              );
              Navigator.of(context).pop();
            } else {
              // Optionally show an error message
              showCustomSnackBar(context, 'Please fill in all fields.');
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
