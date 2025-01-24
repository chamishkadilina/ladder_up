// target_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ladder_up/models/target.dart';

class TargetProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Target? _currentTarget;
  bool _isEditing = false;

  Target? get currentTarget => _currentTarget;
  bool get isEditing => _isEditing;

  Future<void> fetchTarget() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('targets')
          .where('userId', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        _currentTarget = Target.fromFirestore(querySnapshot.docs.first);
      } else {
        // Create a default target if none exists
        _currentTarget = Target(
          title: 'My Target',
          description: 'Add your target description here',
          userId: currentUser.uid,
        );
        await _createDefaultTarget();
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching target: $e');
    }
  }

  Future<void> _createDefaultTarget() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      DocumentReference docRef = await _firestore.collection('targets').add(
            Target(
              title: 'My Target',
              description: 'Add your target description here',
              userId: currentUser.uid,
            ).toMap(),
          );
      _currentTarget?.id = docRef.id;
    } catch (e) {
      print('Error creating default target: $e');
    }
  }

  void toggleEditMode() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> updateTarget(String title, String description) async {
    if (_currentTarget == null) return;

    try {
      _currentTarget!.title = title;
      _currentTarget!.description = description;

      await _firestore
          .collection('targets')
          .doc(_currentTarget!.id)
          .update(_currentTarget!.toMap());

      _isEditing = false;
      notifyListeners();
    } catch (e) {
      print('Error updating target: $e');
    }
  }
}
