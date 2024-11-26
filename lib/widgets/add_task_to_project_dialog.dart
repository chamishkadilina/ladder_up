import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTaskToProjectDialog extends StatefulWidget {
  final Project project;

  const AddTaskToProjectDialog({
    super.key,
    required this.project,
  });

  @override
  _AddTaskToProjectDialogState createState() => _AddTaskToProjectDialogState();
}

class _AddTaskToProjectDialogState extends State<AddTaskToProjectDialog> {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDate;

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add A Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TextField for Task Name
          TextField(
            controller: _taskNameController,
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
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate == null
                        ? "Pick a Date"
                        : DateFormat('MMM dd yyyy').format(_selectedDate!),
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
            if (_taskNameController.text.isNotEmpty) {
              Provider.of<ProjectProvider>(context, listen: false).addTask(
                widget.project,
                _taskNameController.text,
                date: _selectedDate,
              );
            } else {
              // Optionally show an error message
              showCustomSnackBar(context, 'Please fill in all fields');
            }
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
