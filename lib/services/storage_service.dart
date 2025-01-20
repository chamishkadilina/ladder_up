import 'package:hive_flutter/hive_flutter.dart';
import 'package:ladder_up/models/project.dart';

class StorageService {
  static const String projectsBoxName = 'projects';
  static Box<Map>? _projectsBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _projectsBox = await Hive.openBox<Map>(projectsBoxName);
  }

  static Future<void> saveProjects(List<Project> projects) async {
    final projectMaps = projects.map((p) => p.toMap()).toList();
    await _projectsBox?.clear();
    for (var i = 0; i < projectMaps.length; i++) {
      await _projectsBox?.put(i, projectMaps[i]);
    }
  }

  static List<Project> getProjects(String userId) {
    final projectMaps = _projectsBox?.values.toList() ?? [];
    return projectMaps
        .map((map) => Project.fromMap(Map<String, dynamic>.from(map)))
        .where((project) => project.userId == userId)
        .toList();
  }
}
