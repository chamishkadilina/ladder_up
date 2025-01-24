import 'package:flutter/material.dart';
import 'package:ladder_up/navigation_bar.dart';
import 'package:ladder_up/providers/target_provider.dart';
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
      backgroundColor: Colors.white,
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
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                  title: const Text('My Target'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(
                        targetProvider.isEditing ? Icons.check : Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: targetProvider.isEditing
                          ? () {
                              targetProvider.updateTarget(
                                _titleController.text,
                                _descriptionController.text,
                              );
                            }
                          : targetProvider.toggleEditMode,
                    ),
                  ],
                ),
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
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          targetProvider.currentTarget!.description,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black54,
            height: 1.5,
          ),
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
              color: Colors.grey.shade900,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: null,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: 'Write your target description...',
            hintStyle: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 18,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black54,
            height: 1.5,
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
