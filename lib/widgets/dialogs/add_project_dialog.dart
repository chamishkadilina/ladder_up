import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snackbar.dart';
import 'package:provider/provider.dart';

class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController controller = TextEditingController();
  IconData? selectedIcon;

  final List<IconData> availableIcons = [
    Icons.phone_android_sharp,
    Icons.computer,
    Icons.code,
    Icons.web,
    Icons.devices,
    Icons.motorcycle,
    Icons.sports,
    Icons.fitness_center,
    Icons.restaurant,
    Icons.local_cafe,
    Icons.color_lens,
    Icons.music_note,
    Icons.camera_alt,
    Icons.brush,
    Icons.movie,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text("Add New Project"),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Project Name',
                hintText: "Enter project name",
                prefixIcon: const Icon(Icons.edit),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textCapitalization: TextCapitalization.words,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            const Text("Select an Icon:"),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Set a height constraint for the icon grid
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8, // Add spacing between rows
                  children: availableIcons.map((icon) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = icon; // Update selected icon
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          color: selectedIcon == icon
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          icon,
                          color:
                              selectedIcon == icon ? Colors.blue : Colors.black,
                          size: 32,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.isEmpty || selectedIcon == null) {
              if (controller.text.isEmpty && selectedIcon == null) {
                showCustomSnackBar(
                    context, 'Please enter a project name and select an icon');
              } else if (controller.text.isEmpty) {
                showCustomSnackBar(context, 'Please enter a project name');
              } else if (selectedIcon == null) {
                showCustomSnackBar(context, 'Please select an icon');
              }
            } else {
              Provider.of<ProjectProvider>(context, listen: false)
                  .addProject(controller.text, icon: selectedIcon);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Project'),
        ),
      ],
    );
  }
}
