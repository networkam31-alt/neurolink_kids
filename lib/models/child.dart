import 'package:flutter/material.dart';

class ChildProfile {
  final String name;
  final int age;
  final String gender;
  final String school;
  final String diagnosis;
  final bool startedSchool;
  final Color color;

  ChildProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.school,
    required this.diagnosis,
    required this.startedSchool,
    required this.color,
  });

  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}
