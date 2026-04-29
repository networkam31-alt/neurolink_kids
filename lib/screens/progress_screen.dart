import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final child = state.activeChild;
    final reportsForChild =
        state.reports.where((r) => r.childName == child.name).toList();
    final excellent = reportsForChild
        .where((r) => r.performance == 'Excellent')
        .length;
    final good =
        reportsForChild.where((r) => r.performance == 'Good').length;
    final avg =
        reportsForChild.where((r) => r.performance == 'Average').length;
    final poor =
        reportsForChild.where((r) => r.performance == 'Poor').length;
    final total = reportsForChild.length.clamp(1, 9999);

    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.94,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Progrès',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text("Suivi des progrès de ${child.name}",
                  style:
                      const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                          label: 'Activités',
                          value: '24',
                          icon: Icons.bolt,
                          gradient: AppColors.orangeGradient)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                          label: 'Vidéos',
                          value: '8',
                          icon: Icons.play_circle,
                          gradient: AppColors.purpleGradient)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                          label: 'Rapports',
                          value: '${reportsForChild.length}',
                          icon: Icons.description,
                          gradient: AppColors.blueGradient)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                          label: 'Score',
                          value:
                              '${(((excellent * 4 + good * 3 + avg * 2 + poor * 1) / (total * 4)) * 100).round()}%',
                          icon: Icons.star,
                          gradient: AppColors.tealGradient)),
                ],
              ),
              const SizedBox(height: 22),
              const Text('Performance par catégorie',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              _Bar(
                  label: 'Excellent',
                  value: excellent / total,
                  color: AppColors.accentGreen),
              _Bar(
                  label: 'Good',
                  value: good / total,
                  color: AppColors.primary),
              _Bar(
                  label: 'Average',
                  value: avg / total,
                  color: AppColors.accentOrange),
              _Bar(
                  label: 'Poor',
                  value: poor / total,
                  color: AppColors.accentRed),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Gradient gradient;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _Bar(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w800)),
              Text('${(v * 100).round()}%',
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: v,
              minHeight: 10,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}
