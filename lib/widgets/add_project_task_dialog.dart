import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddProjectTaskDialog extends StatefulWidget {
  final Project project;

  const AddProjectTaskDialog({
    super.key,
    required this.project,
  });

  @override
  _AddProjectTaskDialogState createState() => _AddProjectTaskDialogState();
}

class _AddProjectTaskDialogState extends State<AddProjectTaskDialog> {
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
          TextField(
            controller: _taskNameController,
            decoration: const InputDecoration(
              hintText: "Enter task name",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate != null
                    ? "Due date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}"
                    : "No date selected",
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _pickDate(context),
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
            }
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
