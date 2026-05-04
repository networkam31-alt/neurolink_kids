import 'package:flutter/material.dart';

enum ActivityKind {
  colors,
  numbers,
  alphabet,
  animals,
  family,
  drawing,
  memory,
  sorting,
  emotions,
  routine,
  relaxation,
  communication,
}

class ActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Gradient iconGradient;
  final ActivityKind kind;
  const ActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconGradient,
    required this.kind,
  });
}

const _gPink = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFF59E0B)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gTeal = LinearGradient(
  colors: [Color(0xFF2DD4BF), Color(0xFF14B8A6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gAmber = LinearGradient(
  colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gMagenta = LinearGradient(
  colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gOrange = LinearGradient(
  colors: [Color(0xFFFB923C), Color(0xFFF97316)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gPurple = LinearGradient(
  colors: [Color(0xFF818CF8), Color(0xFFA855F7)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gGreen = LinearGradient(
  colors: [Color(0xFF34D399), Color(0xFF10B981)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gMint = LinearGradient(
  colors: [Color(0xFF34D399), Color(0xFF60A5FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gRose = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFF472B6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gCyan = LinearGradient(
  colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gSunset = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFFB923C)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const activities = <ActivityItem>[
  ActivityItem(
    title: 'Colors Learning',
    subtitle: 'Recognize and match colors',
    icon: Icons.palette_rounded,
    iconColor: Colors.white,
    iconGradient: _gPink,
    kind: ActivityKind.colors,
  ),
  ActivityItem(
    title: 'Numbers Learning',
    subtitle: 'Learn counting & numbers',
    icon: Icons.tag_rounded,
    iconColor: Colors.white,
    iconGradient: _gCyan,
    kind: ActivityKind.numbers,
  ),
  ActivityItem(
    title: 'Alphabet Learning',
    subtitle: 'Letters & sounds practice',
    icon: Icons.text_fields_rounded,
    iconColor: Colors.white,
    iconGradient: _gTeal,
    kind: ActivityKind.alphabet,
  ),
  ActivityItem(
    title: 'Animals Learning',
    subtitle: 'Animals & their sounds',
    icon: Icons.pets_rounded,
    iconColor: Colors.white,
    iconGradient: _gAmber,
    kind: ActivityKind.animals,
  ),
  ActivityItem(
    title: 'Family Learning',
    subtitle: 'Family members & relationships',
    icon: Icons.group_rounded,
    iconColor: Colors.white,
    iconGradient: _gMagenta,
    kind: ActivityKind.family,
  ),
  ActivityItem(
    title: 'Drawing Activity',
    subtitle: 'Print & draw creatively',
    icon: Icons.brush_rounded,
    iconColor: Colors.white,
    iconGradient: _gOrange,
    kind: ActivityKind.drawing,
  ),
  ActivityItem(
    title: 'Memory Cards',
    subtitle: 'Match pairs & train memory',
    icon: Icons.psychology_rounded,
    iconColor: Colors.white,
    iconGradient: _gPurple,
    kind: ActivityKind.memory,
  ),
  ActivityItem(
    title: 'Sorting Game',
    subtitle: 'Sort & categorize items',
    icon: Icons.dashboard_rounded,
    iconColor: Colors.white,
    iconGradient: _gMint,
    kind: ActivityKind.sorting,
  ),
  ActivityItem(
    title: 'Émotions',
    subtitle: 'Sentiments',
    icon: Icons.favorite_rounded,
    iconColor: Colors.white,
    iconGradient: _gRose,
    kind: ActivityKind.emotions,
  ),
  ActivityItem(
    title: 'Routine',
    subtitle: 'Plans quotidiens',
    icon: Icons.calendar_month_rounded,
    iconColor: Colors.white,
    iconGradient: _gCyan,
    kind: ActivityKind.routine,
  ),
  ActivityItem(
    title: 'Relaxation',
    subtitle: 'Se calmer',
    icon: Icons.spa_rounded,
    iconColor: Colors.white,
    iconGradient: _gGreen,
    kind: ActivityKind.relaxation,
  ),
  ActivityItem(
    title: 'Communication',
    subtitle: 'Pratiquer la parole',
    icon: Icons.chat_rounded,
    iconColor: Colors.white,
    iconGradient: _gSunset,
    kind: ActivityKind.communication,
  ),
];

class VideoItem {
  final String title;
  final String tag;
  final String duration;
  final IconData icon;
  final Gradient gradient;
  const VideoItem({
    required this.title,
    required this.tag,
    required this.duration,
    required this.icon,
    required this.gradient,
  });
}

const videos = <VideoItem>[
  VideoItem(
    title: 'Hand Washing Steps',
    tag: 'Daily life',
    duration: '4 min',
    icon: Icons.wash_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
    ),
  ),
  VideoItem(
    title: 'Greeting a Friend',
    tag: 'Social',
    duration: '3 min',
    icon: Icons.handshake_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
    ),
  ),
  VideoItem(
    title: 'Counting to Ten',
    tag: 'Cognitive',
    duration: '5 min',
    icon: Icons.calculate_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFF22D3EE)],
    ),
  ),
];
