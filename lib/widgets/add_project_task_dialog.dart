import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:provider/provider.dart';

class AddProjectTaskDialog extends StatelessWidget {
  final Project project;

  const AddProjectTaskDialog({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text("Add A Task"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Enter task name",
        ),
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
            if (controller.text.isNotEmpty) {
              Provider.of<ProjectProvider>(context, listen: false)
                  .addTask(project, controller.text);
            }
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
