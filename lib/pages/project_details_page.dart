import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/add_task_to_project_dialog.dart';
import 'package:ladder_up/widgets/section_header.dart';

import 'package:ladder_up/widgets/subtask_list_view.dart';
import 'package:provider/provider.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({
    required this.project,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);
    final incompleteTasks = projectProvider.getIncompleteTasks(project);
    final completedTasks = projectProvider.getCompletedTasks(project);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),

            // Task List Section
            SectionHeader(
              title: 'Task List',
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (context) =>
                      AddTaskToProjectDialog(project: project),
                );
              },
            ),

            const SizedBox(height: 16),

            // In Progress Tasks
            const Text(
              'In Progress',
              style: TextStyle(fontSize: 20),
            ),
            incompleteTasks.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'No tasks are currently in progress. Add a new task to get started!',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                : SubtaskListView(
                    tasks: incompleteTasks,
                    projectProvider: projectProvider,
                    project: project,
                  ),
            const SizedBox(height: 16),

            // Completed Tasks
            const Text(
              'Completed',
              style: TextStyle(fontSize: 20),
            ),
            completedTasks.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'No tasks have been completed yet.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                : SubtaskListView(
                    tasks: completedTasks,
                    projectProvider: projectProvider,
                    project: project,
                  ),
          ],
        ),
      ),
    );
  }
}
