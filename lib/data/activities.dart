import 'package:flutter/material.dart';

import '../app_theme.dart';

enum ActivityKind { colors, shapes, numbers, words, emotions, animals }

class ActivityItem {
  final String title;
  final String tag;
  final IconData icon;
  final Gradient gradient;
  final ActivityKind kind;
  const ActivityItem({
    required this.title,
    required this.tag,
    required this.icon,
    required this.gradient,
    required this.kind,
  });
}

const activities = <ActivityItem>[
  ActivityItem(
    title: 'Apprendre les couleurs',
    tag: 'Cognitif',
    icon: Icons.palette_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
    ),
    kind: ActivityKind.colors,
  ),
  ActivityItem(
    title: 'Apprendre les formes',
    tag: 'Cognitif',
    icon: Icons.category_rounded,
    gradient: LinearGradient(colors: [Color(0xFF4F8FFB), Color(0xFF2DD4BF)]),
    kind: ActivityKind.shapes,
  ),
  ActivityItem(
    title: 'Compter les nombres',
    tag: 'Mathématiques',
    icon: Icons.calculate_rounded,
    gradient: LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)]),
    kind: ActivityKind.numbers,
  ),
  ActivityItem(
    title: 'Apprendre des mots',
    tag: 'Langage',
    icon: Icons.menu_book_rounded,
    gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF2DD4BF)]),
    kind: ActivityKind.words,
  ),
  ActivityItem(
    title: 'Reconnaître les émotions',
    tag: 'Social',
    icon: Icons.emoji_emotions_rounded,
    gradient: LinearGradient(colors: [Color(0xFFFBBF24), Color(0xFFF97316)]),
    kind: ActivityKind.emotions,
  ),
  ActivityItem(
    title: 'Découvrir les animaux',
    tag: 'Découverte',
    icon: Icons.pets_rounded,
    gradient: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFEF4444)]),
    kind: ActivityKind.animals,
  ),
];

class VideoItem {
  final String title;
  final String tag;
  final String duration;
  final IconData icon;
  final Gradient gradient;
  const VideoItem(
      {required this.title,
      required this.tag,
      required this.duration,
      required this.icon,
      required this.gradient});
}

const videos = <VideoItem>[
  VideoItem(
    title: 'Gérer les émotions',
    tag: 'Émotions',
    duration: '5:30',
    icon: Icons.psychology_alt,
    gradient: AppColors.tealGradient,
  ),
  VideoItem(
    title: 'Enseigner les bonnes manières',
    tag: 'Social',
    duration: '4:10',
    icon: Icons.handshake_outlined,
    gradient: AppColors.purpleGradient,
  ),
  VideoItem(
    title: 'La routine du matin',
    tag: 'Quotidien',
    duration: '3:45',
    icon: Icons.alarm,
    gradient: AppColors.blueGradient,
  ),
  VideoItem(
    title: 'Communiquer simplement',
    tag: 'Langage',
    duration: '6:20',
    icon: Icons.record_voice_over,
    gradient: AppColors.orangeGradient,
  ),
];
