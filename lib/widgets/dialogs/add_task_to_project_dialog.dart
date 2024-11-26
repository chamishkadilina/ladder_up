import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddTaskToProjectDialog extends StatefulWidget {
  final Project project;

  const AddTaskToProjectDialog({
    super.key,
    required this.project,
  });

  @override
  AddTaskToProjectDialogState createState() => AddTaskToProjectDialogState();
}

class AddTaskToProjectDialogState extends State<AddTaskToProjectDialog> {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDate;

  void _pickDate() async {
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

  void _addTask(BuildContext context) {
    if (_taskNameController.text.isEmpty || _selectedDate == null) {
      showCustomSnackBar(context, 'Please fill in all fields.');
      return;
    }

    Provider.of<ProjectProvider>(context, listen: false).addTask(
      widget.project,
      _taskNameController.text,
      date: _selectedDate,
    );

    Navigator.of(context).pop();
    showCustomSnackBar(
      context,
      'Task "${_taskNameController.text}" added successfully!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add a Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _taskNameController,
            decoration: const InputDecoration(
              labelText: "Task Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickDate,
                  child: Text(
                    _selectedDate == null
                        ? "Pick a Date"
                        : DateFormat('MMM dd, yyyy').format(_selectedDate!),
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
          onPressed: () => _addTask(context),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
