import 'package:flutter/material.dart';

import '../data/activities.dart';
import 'activities/alphabet_screen.dart';
import 'activities/animals_screen.dart';
import 'activities/colors_screen.dart';
import 'activities/communication_screen.dart';
import 'activities/drawing_screen.dart';
import 'activities/emotions_screen.dart';
import 'activities/family_screen.dart';
import 'activities/memory_screen.dart';
import 'activities/numbers_screen.dart';
import 'activities/relaxation_screen.dart';
import 'activities/routine_screen.dart';
import 'activities/sorting_screen.dart';

/// Routes an [ActivityItem] to the matching detail screen.
class ActivityDetailScreen extends StatelessWidget {
  final ActivityItem item;
  const ActivityDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.kind) {
      case ActivityKind.colors:
        return const ColorsScreen();
      case ActivityKind.numbers:
        return const NumbersScreen();
      case ActivityKind.alphabet:
        return const AlphabetScreen();
      case ActivityKind.animals:
        return const AnimalsScreen();
      case ActivityKind.family:
        return const FamilyScreen();
      case ActivityKind.drawing:
        return const DrawingScreen();
      case ActivityKind.memory:
        return const MemoryScreen();
      case ActivityKind.sorting:
        return const SortingScreen();
      case ActivityKind.emotions:
        return const EmotionsScreen();
      case ActivityKind.routine:
        return const RoutineScreen();
      case ActivityKind.relaxation:
        return const RelaxationScreen();
      case ActivityKind.communication:
        return const CommunicationScreen();
    }
  }
}
