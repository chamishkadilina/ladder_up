import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ladder_up/pages/project_details_page.dart';
import 'package:ladder_up/providers/project_provider.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({
    super.key,
    required this.projectProvider,
  });

  final ProjectProvider projectProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectProvider.projects.length,
      itemBuilder: (context, index) {
        final project = projectProvider.projects[index]; // get specific project

        // calculate progress percentage
        final totalSubtasks = project.subtasks.length;
        final completedSubtasks =
            projectProvider.getCompletedTasks(project).length;
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

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
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
                  builder: (context) => ProjectDetailsPage(project: project),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
