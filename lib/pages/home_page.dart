import 'package:flutter/material.dart';
import 'package:ladder_up/providers/project_provider.dart';
import 'package:ladder_up/widgets/dialogs/add_project_dialog.dart';
import 'package:ladder_up/widgets/empty_state.dart';
import 'package:ladder_up/widgets/project_list.dart';
import 'package:ladder_up/widgets/section_header.dart';
import 'package:ladder_up/widgets/task_list_regular.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projectProvider =
          Provider.of<ProjectProvider>(context, listen: false);
      projectProvider.fetchProjects().then((_) {
        // Reschedule notifications after fetching projects
        projectProvider.scheduleTaskNotifications();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final todayTasks = projectProvider.getTasksForToday();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Column(
            children: [
              // My Projects Section
              SectionHeader(
                title: 'My Projects',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddProjectDialog(),
                  );
                },
              ),
              const SizedBox(height: 8),

              // Project List
              Expanded(
                flex: 1,
                child: projectProvider.projects.isEmpty
                    ? const EmptyState(
                        text: 'No projects added yet. Tap "+" to create one!',
                      )
                    : ProjectList(projectProvider: projectProvider),
              ),
              const SizedBox(height: 8),

              // Today's Task Section
              const SectionHeader(
                title: "Today's task",
                showButton: false,
              ),
              const SizedBox(height: 8),

              // Display Today's Task List
              Expanded(
                flex: 1,
                child: TaskListRegular(
                  tasks: todayTasks,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
