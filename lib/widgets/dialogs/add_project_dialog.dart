import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController controller = TextEditingController();
  String? selectedEmoji;

  final List<String> availableEmojis = [
    '💻', // Laptop
    '📱', // Mobile Phone
    '🖥️', // Desktop Computer
    '🌐', // Globe
    '🚀', // Rocket
    '🏀', // Basketball
    '🏋️', // Weight Lifting
    '🍽️', // Plate and Cutlery
    '☕', // Coffee
    '🎨', // Palette
    '🎵', // Musical Note
    '📷', // Camera
    '🖌️', // Paintbrush
    '🎬', // Clapperboard
    '📊', // Bar Chart
    '🤖', // Robot
    '🔬', // Microscope
    '✈️', // Airplane
    '🚲', // Bicycle
    '🌍', // Earth Globe
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
            const Text("Select an Emoji:"),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Set a height constraint for the emoji grid
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8, // Add spacing between rows
                  children: availableEmojis.map((emoji) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEmoji = emoji; // Update selected emoji
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          color: selectedEmoji == emoji
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          emoji,
                          style: TextStyle(
                            fontSize: 32,
                            color: selectedEmoji == emoji
                                ? Colors.blue
                                : Colors.black,
                          ),
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
            if (controller.text.isEmpty || selectedEmoji == null) {
              if (controller.text.isEmpty && selectedEmoji == null) {
                showCustomSnackBar(
                    context, 'Please enter a project name and select an emoji');
              } else if (controller.text.isEmpty) {
                showCustomSnackBar(context, 'Please enter a project name');
              } else if (selectedEmoji == null) {
                showCustomSnackBar(context, 'Please select an emoji');
              }
            } else {
              // If selectedEmoji is null, set a default emoji or handle it
              final emojiToAdd =
                  selectedEmoji ?? '🌍'; // Default emoji if none selected

              // Pass the emoji to the provider method
              Provider.of<ProjectProvider>(context, listen: false)
                  .addProject(controller.text, emoji: emojiToAdd);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Project'),
        )
      ],
    );
  }
}
