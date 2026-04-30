import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/report.dart';

enum UserRole { parent, teacher, doctor }

enum AppLanguage { en, fr, ar }

class AppState extends ChangeNotifier {
  UserRole role = UserRole.parent;
  AppLanguage language = AppLanguage.fr;
  String userName = 'Parent';

  final List<ChildProfile> children = [
    ChildProfile(
      name: 'Emma',
      age: 7,
      gender: 'Girl',
      school: 'Sunshine Primary',
      diagnosis: 'Autism Spectrum Disorder (Level 1)',
      startedSchool: true,
      color: const Color(0xFFF59E0B),
    ),
    ChildProfile(
      name: 'Charlie',
      age: 6,
      gender: 'Boy',
      school: 'Bright Start School',
      diagnosis: 'ADHD',
      startedSchool: true,
      color: const Color(0xFF2DD4BF),
    ),
  ];

  int activeChildIndex = 0;
  ChildProfile get activeChild => children[activeChildIndex];

  final List<DailyReport> reports = [
    DailyReport(
      childName: 'Charlie',
      date: DateTime(2026, 4, 24),
      authorRole: 'Teacher',
      emotion: '😄',
      behaviors: ['Focused', 'Social'],
      strangeBehavior: false,
      strangeBehaviorNote: '',
      performance: 'Excellent',
      learningActivities: ['Reading', 'Math'],
      notes: 'Charlie showed great improvement in reading comprehension today.',
    ),
    DailyReport(
      childName: 'Charlie',
      date: DateTime(2026, 4, 22),
      authorRole: 'Parent',
      emotion: '🙂',
      behaviors: ['Calm'],
      strangeBehavior: true,
      strangeBehaviorNote: 'Charlie repeatedly tapped on the desk during group activity.',
      performance: 'Good',
      learningActivities: ['Drawing'],
      notes: 'Showed some difficulty focusing during afternoon session.',
    ),
    DailyReport(
      childName: 'Charlie',
      date: DateTime(2026, 4, 20),
      authorRole: 'Teacher',
      emotion: '😆',
      behaviors: ['Focused', 'Social', 'Calm'],
      strangeBehavior: false,
      strangeBehaviorNote: '',
      performance: 'Excellent',
      learningActivities: ['Reading', 'Drawing'],
      notes: 'Excellent participation in group reading activity.',
    ),
  ];

  final List<MedicalReport> medicalReports = [];

  int stars = 0;

  void addStars(int n) {
    if (n <= 0) return;
    stars += n;
    notifyListeners();
  }

  void resetStars() {
    stars = 0;
    notifyListeners();
  }

  void setRole(UserRole r) {
    role = r;
    notifyListeners();
  }

  void setLanguage(AppLanguage l) {
    language = l;
    notifyListeners();
  }

  void setActiveChild(int i) {
    activeChildIndex = i;
    notifyListeners();
  }

  void addChild(ChildProfile c) {
    children.add(c);
    notifyListeners();
  }

  void addReport(DailyReport r) {
    reports.insert(0, r);
    notifyListeners();
  }

  void addMedicalReport(MedicalReport r) {
    medicalReports.insert(0, r);
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in widget tree');
    return scope!.notifier!;
  }
}
