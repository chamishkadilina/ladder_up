import 'package:flutter/material.dart';
import 'package:ladder_up/models/project.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/dialogs/add_task_to_project_dialog.dart';
import 'package:ladder_up/widgets/dialogs/project_delete_dialog.dart';
import 'package:ladder_up/widgets/dialogs/project_rename_dialog.dart.dart';
import 'package:ladder_up/widgets/section_header.dart';
import 'package:ladder_up/widgets/task_list_detailed.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

    // Calculate progress percentage
    final totalSubtasks = project.subtasks.length;
    final completedSubtasks = projectProvider.getCompletedTasks(project).length;
    final progress = totalSubtasks > 0
        ? (completedSubtasks / totalSubtasks * 100).round()
        : 0;

    // Determine project start and end dates
    final startDate = projectProvider.getProjectStartDate(project);
    final endDate = projectProvider.getProjectEndDate(project);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final formattedStartDate =
        startDate != null ? dateFormat.format(startDate) : 'N/A';
    final formattedEndDate =
        endDate != null ? dateFormat.format(endDate) : 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
        actions: [
          // Pop up menu button
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'rename') {
                showProjectRenameDialog(context, project);
              } else if (value == 'delete') {
                showProjectDeleteDialog(context, projectProvider, project);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'rename',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Rename Project'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Project'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top section - Project title, dates, and progress
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Text(
                  project.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  project.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date range and completion percentage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$formattedStartDate - $formattedEndDate',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          '$progress %',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: totalSubtasks > 0
                          ? completedSubtasks / totalSubtasks
                          : 0, // Avoid division by zero
                      minHeight: 4,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                onTap: () {
                  // Navigate to Project Details Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProjectDetailsPage(project: project),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 8),

            // incompleted Tasks
            incompleteTasks.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'No tasks are currently in progress. Add a new task to get started!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                  )
                : TaskListDetailed(
                    tasks: incompleteTasks,
                    projectProvider: projectProvider,
                    project: project,
                  ),
            const SizedBox(height: 16),

            // Completed Tasks
            Text(
              'Completed',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            completedTasks.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/ic_notasks.png',
                            scale: 2.4,
                          ),
                          Text(
                            'No tasks have been completed yet.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : TaskListDetailed(
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
