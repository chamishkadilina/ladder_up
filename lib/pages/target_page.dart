import 'package:flutter/material.dart';
import 'package:ladder_up/navigation_bar.dart';
import 'package:ladder_up/providers/target_provider.dart';
import 'package:ladder_up/theme/custom_themes/text_theme.dart';
import 'package:provider/provider.dart';

class TargetPage extends StatefulWidget {
  const TargetPage({super.key});

  @override
  _TargetPageState createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TargetProvider>().fetchTarget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MyNavigationBar();
                },
              ),
            );
          },
        ),
        title: Text(
          'My Target',
          style: Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.titleLarge
              : MyTextTheme.lightTextTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Consumer<TargetProvider>(
            builder: (context, targetProvider, child) {
              return IconButton(
                icon: Icon(
                  targetProvider.isEditing ? Icons.check : Icons.edit,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
                onPressed: targetProvider.isEditing
                    ? () {
                        targetProvider.updateTarget(
                          _titleController.text,
                          _descriptionController.text,
                        );
                      }
                    : targetProvider.toggleEditMode,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<TargetProvider>(
          builder: (context, targetProvider, child) {
            if (targetProvider.currentTarget == null) {
              return const Center(child: CircularProgressIndicator());
            }

            _titleController = TextEditingController(
              text: targetProvider.currentTarget!.title,
            );
            _descriptionController = TextEditingController(
              text: targetProvider.currentTarget!.description,
            );

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: targetProvider.isEditing
                        ? _buildEditView(targetProvider)
                        : _buildPreviewView(targetProvider),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreviewView(TargetProvider targetProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          targetProvider.currentTarget!.title,
          style: Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.displayLarge
              : MyTextTheme.lightTextTheme.displayLarge,
        ),
        const SizedBox(height: 16),
        Text(
          targetProvider.currentTarget!.description,
          style: Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.bodyMedium
              : MyTextTheme.lightTextTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildEditView(TargetProvider targetProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? MyTextTheme.darkTextTheme.headlineLarge?.color
                  : MyTextTheme.lightTextTheme.headlineLarge?.color,
            ),
            border: InputBorder.none,
          ),
          style: Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.displayLarge
              : MyTextTheme.lightTextTheme.displayLarge,
          maxLines: null,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: 'Write your target description...',
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? MyTextTheme.darkTextTheme.bodyMedium?.color
                  : MyTextTheme.lightTextTheme.bodyMedium?.color,
              fontSize: 18,
            ),
            border: InputBorder.none,
          ),
          style: Theme.of(context).brightness == Brightness.dark
              ? MyTextTheme.darkTextTheme.bodyMedium
              : MyTextTheme.lightTextTheme.bodyMedium,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
