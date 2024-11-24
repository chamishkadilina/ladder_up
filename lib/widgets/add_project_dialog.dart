import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
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
    Icons.motorcycle,
    Icons.color_lens,
    Icons.sports,
    Icons.home,
    Icons.shopping_cart,
    Icons.book,
    Icons.pets,
    Icons.travel_explore,
    Icons.phone_android_sharp,
    Icons.motorcycle,
    Icons.color_lens,
    Icons.sports,
    Icons.home,
    Icons.shopping_cart,
    Icons.book,
    Icons.pets,
    Icons.travel_explore,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Project"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter project name",
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select an Icon:"),
            const SizedBox(height: 8),
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
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty && selectedIcon != null) {
              Provider.of<ProjectProvider>(context, listen: false)
                  .addProject(controller.text, icon: selectedIcon);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
