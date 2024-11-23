import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:provider/provider.dart';

class AddProjectDialog extends StatelessWidget {
  const AddProjectDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text("Add Project"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Enter project name",
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
                  .addProject(controller.text);
            }
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
