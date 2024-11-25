import 'package:flutter/material.dart';
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
        final project = projectProvider.projects[index];
        return Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Icon(project.icon),
            title: Text(
              project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'project.startDate : project.endDate',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      '80 %',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 80 / 100,
                  minHeight: 6,
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
