import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/add_project_dialog.dart';
import 'package:ladder_up/widgets/empty_state.dart';
import 'package:ladder_up/widgets/project_list.dart';
import 'package:ladder_up/widgets/section_header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              // My Projects Section
              SectionHeader(
                title: 'My Projects',
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (context) => const AddProjectDialog(),
                  );
                },
              ),
              const SizedBox(height: 8),

              // project list
              Expanded(
                child: projectProvider.projects.isEmpty
                    ?
                    // if there no projects, show this message
                    const EmptyState(
                        text: 'No projects added yet. Tap "+" to create one!')
                    // show project list
                    : ProjectList(projectProvider: projectProvider),
              ),
              const SizedBox(height: 8),

              // Today task Section
              SectionHeader(
                title: "Today's task",
                onTap: () {},
              ),

              // Today's Task List
              const Expanded(
                child: Center(
                  child: Text(
                    'No tasks for today. Tap "+" to add some!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
